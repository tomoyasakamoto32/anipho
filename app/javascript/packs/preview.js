if (document.URL.match( /new/ ) || document.URL.match( /edit/ ) || document.URL.match( /posts/ ) ) {
function preview(){
  const ImageList1 = document.getElementById('image-list1');
  const ImageList2 = document.getElementById('image-list2');
  const ImageList3 = document.getElementById('image-list3');
  const ImageList4 = document.getElementById('image-list4');
  const ImageList5 = document.getElementById('image-list5');

  //ここからフォーム1つ目
  const createImageHTML1 = (blob) => {
   const imageElement = document.createElement('div');

   const blobImage = document.createElement('img');
   blobImage.setAttribute('src', blob);
   blobImage.setAttribute('id', `image_1`)

   imageElement.appendChild(blobImage);
   ImageList1.appendChild(imageElement);

   inputHTML.addEventListener('change', (e) => {
    file = e.target.files[0];
    blob = window.URL.createObjectURL(file);

    createImageHTML1(blob)
  })
 };

  document.getElementById('message_image_1').addEventListener('change', function(e){
    const imageContent = document.getElementById('image_1');
      if (imageContent){
        imageContent.remove();
      }

    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);

    createImageHTML1(blob);
  });
  //ここまで

  //ここからフォーム2つ目
  const createImageHTML2 = (blob) => {
    const imageElement = document.createElement('div');
 
 
    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('id', `image_2`)
 
    imageElement.appendChild(blobImage);
    ImageList2.appendChild(imageElement);
 
    inputHTML.addEventListener('change', (e) => {
     file = e.target.files[0];
     blob = window.URL.createObjectURL(file);
 
     createImageHTML2(blob)
   })
  };
 
   document.getElementById('message_image_2').addEventListener('change', function(e){
     const imageContent = document.getElementById('image_2');
       if (imageContent){
         imageContent.remove();
       }
 
     const file = e.target.files[0];
     const blob = window.URL.createObjectURL(file);
 
     createImageHTML2(blob);
   });
   //ここまで

   //ここからフォーム3つ目
   const createImageHTML3 = (blob) => {
    const imageElement = document.createElement('div');
 
 
    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('id', `image_3`)
 
    imageElement.appendChild(blobImage);
    ImageList3.appendChild(imageElement);
 
    inputHTML.addEventListener('change', (e) => {
     file = e.target.files[0];
     blob = window.URL.createObjectURL(file);
 
     createImageHTML3(blob)
   })
  };
 
   document.getElementById('message_image_3').addEventListener('change', function(e){
     const imageContent = document.getElementById('image_3');
       if (imageContent){
         imageContent.remove();
       }
 
     const file = e.target.files[0];
     const blob = window.URL.createObjectURL(file);
 
     createImageHTML3(blob);
   });
   //ここまで

   //ここからフォーム4つ目
   const createImageHTML4 = (blob) => {
    const imageElement = document.createElement('div');
 
 
    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('id', `image_4`)
 
    imageElement.appendChild(blobImage);
    ImageList4.appendChild(imageElement);
 
    inputHTML.addEventListener('change', (e) => {
     file = e.target.files[0];
     blob = window.URL.createObjectURL(file);
 
     createImageHTML4(blob)
   })
  };
 
   document.getElementById('message_image_4').addEventListener('change', function(e){
     const imageContent = document.getElementById('image_4');
       if (imageContent){
         imageContent.remove();
       }
 
     const file = e.target.files[0];
     const blob = window.URL.createObjectURL(file);
 
     createImageHTML4(blob);
   });
  //ここまで

  //ここからフォーム5つ目
  const createImageHTML5 = (blob) => {
    const imageElement = document.createElement('div');
 
 
    const blobImage = document.createElement('img');
    blobImage.setAttribute('src', blob);
    blobImage.setAttribute('id', `image_5`)
 
    imageElement.appendChild(blobImage);
    ImageList5.appendChild(imageElement);
 
    inputHTML.addEventListener('change', (e) => {
     file = e.target.files[0];
     blob = window.URL.createObjectURL(file);
 
     createImageHTML5(blob)
   })
  };
 
   document.getElementById('message_image_5').addEventListener('change', function(e){
     const imageContent = document.getElementById('image_5');
       if (imageContent){
         imageContent.remove();
       }
 
     const file = e.target.files[0];
     const blob = window.URL.createObjectURL(file);
 
     createImageHTML5(blob);
   });
   //ここまで
}
addEventListener('DOMContentLoaded', preview)
}