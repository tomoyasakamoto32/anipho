function hover (){
  const pullDownButton = document.getElementById('category');
  const pullDownTop = document.getElementById('category-top')
  const pullDownElement = document.getElementById('hidden');
  pullDownButton.addEventListener('mouseover',function(){
    pullDownElement.setAttribute("style", "display:block;");
  })
  pullDownButton.addEventListener('mouseout', function(){
    pullDownElement.removeAttribute("style", "display:block;");
  })
  pullDownTop.addEventListener('mouseover', function(){
    pullDownTop.setAttribute("style", "background-color:#a18068;");
  })
  pullDownTop.addEventListener('mouseout', function(){
    pullDownTop.removeAttribute("style", "background-color:#a18068;");
  })
}
window.addEventListener('load', hover);