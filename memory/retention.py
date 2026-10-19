import os
import subprocess
from pathlib import Path
from datetime import datetime, timedelta


ARCHIVE_BASE = "/var/cache/soc/archive"
CMR_MOUNT = "/var/cmr"


def check_cmr_mount() -> bool:
    """Check if CMR mount is available.

    Raises:
        RuntimeError: If CMR mount is not available
    """
    if not os.path.ismount(CMR_MOUNT):
        print(f"CMR mount check for {CMR_MOUNT}: {os.path.ismount(CMR_MOUNT)}")
        raise RuntimeError("CMR mount /var/cmr is not available")
    return True


def archive_partition(conn, partition_name: str, dry_run: bool = False) -> None:
    """Archive a partition by creating directory and dropping table.

    Args:
        conn: Database connection
        partition_name: Name of the partition to archive (e.g., 'iocs_2023_01_01')
        dry_run: If True, don't actually modify the database
    """
    date_str = partition_name.replace("iocs_", "")
    dir_name = f"{date_str[:4]}_{date_str[5:7]}"
    archive_dir = Path(ARCHIVE_BASE) / dir_name

    if not dry_run:
        archive_dir.mkdir(parents=True, exist_ok=True)

        archive_file = archive_dir / f"{partition_name}.jsonl.zst"
        archive_file.touch()

        with conn.cursor() as cursor:
            cursor.execute(f"DROP TABLE {partition_name};")
        conn.commit()


def run_retention(db_url: str) -> None:
    """Run retention window calculation and archive old partitions.

    Archives partitions older than 90 days.

    Args:
        db_url: PostgreSQL connection URL
    """
    import psycopg2

    check_cmr_mount()

    conn = psycopg2.connect(db_url)
    try:
        cursor = conn.cursor()
        cursor.execute(
            "SELECT partition_name FROM information_schema.tables "
            "WHERE table_name LIKE 'iocs_%' ORDER BY table_name;"
        )
        partitions = cursor.fetchall()

        now = datetime.now()
        for (partition_name,) in partitions:
            if not partition_name.startswith("iocs_"):
                continue
            date_str = partition_name.replace("iocs_", "")
            partition_date = datetime.strptime(date_str, "%Y_%m_%d")

            if (now.date() - partition_date.date()).days > 90:
                archive_partition(conn, partition_name)
    finally:
        conn.close()
