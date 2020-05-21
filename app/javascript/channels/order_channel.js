import consumer from "./consumer"

consumer.subscriptions.create({channel: "OrderChannel", user_id: gon.user_id}, {
    connected() {
    },

    disconnected() {
    },

    received(data) {
        const body = data["body"]
        const paths = window.location.href.split("/").reverse()
        const notice = document.getElementById('notice').MDCSnackbar;
        notice.labelText = "Ha recibido una actualización en un pedido";
        if (paths[0] === "orders") {
            document.getElementById("orders").outerHTML = body["general"]
            notice.open()
        } else if (paths[0] === body["id"]) {
            document.getElementById("orders").outerHTML = body["specific"]
            notice.open()
        }
    }
});
