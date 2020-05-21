document.renderElement = (id) => {
    const ing = gon.ingredients[id]
    const cant = document.ingredients[id]
    return `<li class="mdc-list-item" onclick="onIngredientSelectedClick(${id})">` +
        `     <span class="mdc-list-item__text">` +
        `       <span class="mdc-list-item__primary-text">${ing["name"]}</span>` +
        `       <span class="mdc-list-item__secondary-text">Cantidad: ${cant} · $ ${ing["price"] * cant}</span>` +
        `       <input name="order[ingredients][${id}]" value="${cant}" class="hide">` +
        `     </span>` +
        `   </li>`
}

document.renderSelectedElements = () => {
    let el = document.getElementById("selected-ingredients")
    if (el) {
        let inner = ""
        let total = 0
        for (let id in document.ingredients) {
            inner += document.renderElement(id)
            total += document.ingredients[id] * gon.ingredients[id]["price"]
        }
        el.innerHTML = inner
        el = document.getElementById("total")
        if (el) el.innerHTML = `$ ${total}`
    }
}

document.ingredients = {}

document.onIngredientClick = (id) => {
    if (document.ingredients[id]) document.ingredients[id]++
    else document.ingredients[id] = 1
    document.renderSelectedElements()
}

document.onIngredientSelectedClick = (id) => {
    if (document.ingredients[id] === 1) delete document.ingredients[id]
    else document.ingredients[id]--
    document.renderSelectedElements()
}
