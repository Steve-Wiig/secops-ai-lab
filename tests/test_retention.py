import pytest
from datetime import datetime, timedelta
from memory.retention import check_cmr_mount


def test_check_cmr_mount_raises_when_not_available(mocker):
    """Test that check_cmr_mount raises RuntimeError when CMR is not mounted."""
    mocker.patch("os.path.ismount", return_value=False)

    with pytest.raises(RuntimeError, match="CMR mount /var/cmr is not available"):
        check_cmr_mount()


def test_check_cmr_mount_passes_when_available(mocker):
    """Test that check_cmr_mount passes when CMR is mounted."""
    mocker.patch("os.path.ismount", return_value=True)

    result = check_cmr_mount()
    assert result is True
