const slide0 = document.getElementById("slide-0");
const slide1 = document.getElementById("slide-1");
const slide2 = document.getElementById("slide-2");
let nextSlide = 1;

setInterval(() => {
    switch (nextSlide) {
        case 0:
            slide0.classList.add("shown");
            slide1.classList.remove("shown");
            slide2.classList.remove("shown");
            break;
        case 1:
            slide1.classList.add("shown");
            slide0.classList.remove("shown");
            slide2.classList.remove("shown");
            break;
        case 2:
            slide2.classList.add("shown");
            slide0.classList.remove("shown");
            slide1.classList.remove("shown");
            break;
    }
    nextSlide = (nextSlide + 1) % 3;
}, 4000);
