import pytest
from pytest_mock import MockerFixture
from datetime import datetime, timedelta
from memory.retention import check_cmr_mount, CMR_MOUNT


def test_check_cmr_mount_raises_when_not_available(mocker: MockerFixture):
    """Test that check_cmr_mount raises RuntimeError when CMR is not mounted."""
    mock_ismount = mocker.patch("memory.retention.os.path.ismount", return_value=False)
    
    with pytest.raises(RuntimeError, match=f"CMR mount {CMR_MOUNT} is not available"):
        check_cmr_mount()
    
    mock_ismount.assert_called_once_with("/var/cmr")


def test_check_cmr_mount_passes_when_available(mocker: MockerFixture):
    """Test that check_cmr_mount passes when CMR is mounted."""
    mocker.patch("memory.retention.os.path.ismount", return_value=True)

    result = check_cmr_mount()
    assert result is True
