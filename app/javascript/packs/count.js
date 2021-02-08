function count (){
  const postText = document.getElementById('post_text');
  const animalName = document.getElementById('animal_name');
  const explanation = document.getElementById('explanation');
  const tag = document.getElementById('tag');

  postText.addEventListener("keyup", () => {
   let titleLength = postText.value.length
   let countTitle = document.getElementById('count_title')
   if (titleLength > 40){
     titleLength = 40
   }
   countTitle.innerHTML = `${titleLength}文字`
  });

  animalName.addEventListener("keyup", () => {
    let nameLength = animalName.value.length
    let countName = document.getElementById('count_name')
    if (nameLength > 30) {
      nameLength = 30
    }
    countName.innerHTML = `${nameLength}文字`
  });

  explanation.addEventListener("keyup", () => {
    let explanationLength = explanation.value.length
    let countExplanation = document.getElementById('count_explanation')
    if (explanationLength > 1000) {
      explanationLength = 1000
    }
    countExplanation.innerHTML = `${explanationLength}文字`
  });

  tag.addEventListener('keyup', () => {
    let tagLength = tag.value.length
    let countTag = document.getElementById('count_tag');
    if (tagLength > 30) {
      tagLength = 30
    }
    countTag.innerHTML = `${tagLength}文字`
  });
}
window.addEventListener('load', count);