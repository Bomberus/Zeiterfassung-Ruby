function set(id, deg) {
    var el = document.getElementById(id),
        rotation = 'rotate(' + deg + 'deg)';

    el.style.transform = rotation;
    el.style.webkitTransform = rotation;
}

$(document).ready(function (){
    set('hours',   30 * new Date().getHours());
    set('minutes',  6 * new Date().getMinutes());
    set('seconds', 10 * new Date().getSeconds());
});