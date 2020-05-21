import consumer from "./consumer"

consumer.subscriptions.create({channel: "OrderChannel", user_id: gon.user_id}, {
    connected() {
        // Called when the subscription is ready for use on the server
    },

    disconnected() {
        // Called when the subscription has been terminated by the server
    },

    received(data) {
        const body = data["body"]
        const paths = window.location.href.split("/").reverse()
        if (paths[0] === "orders") document.getElementById("orders").outerHTML = body["general"]
        else if (paths[0] === `${data["id"]}`) document.getElementById("orders").outerHTML = body["specific"]
        console.log(paths)
        console.log(body)
    }
});
