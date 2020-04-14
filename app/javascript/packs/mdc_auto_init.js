import {autoInit} from "material-components-web";

autoInit();

const notice_msg = gon.notice;

if (notice_msg) {
    const notice = document.getElementById('notice').MDCSnackbar;
    notice.labelText = notice_msg;
    notice.open();
}
