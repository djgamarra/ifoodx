import {autoInit, topAppBar} from "material-components-web";

function load() {
    autoInit.register("MDCTopAppBar", topAppBar.MDCTopAppBar)
    autoInit();
    const notice_msg = gon.notice;
    if (notice_msg) {
        const notice = document.getElementById('notice').MDCSnackbar;
        notice.labelText = notice_msg;
        notice.open();
    }
}

load()

document.addEventListener('load turbolinks:load', load)
