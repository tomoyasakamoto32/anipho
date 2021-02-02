function hover (){
  const pullDownButton = document.getElementById('category');
  const pullDownElement = document.getElementById('hidden');
  pullDownButton.addEventListener('mouseover',function(){
    pullDownElement.setAttribute("style", "display:block;");
  })
  pullDownButton.addEventListener('mouseout', function(){
    pullDownElement.removeAttribute("style", "display:block;");
  })
}
window.addEventListener('load', hover);