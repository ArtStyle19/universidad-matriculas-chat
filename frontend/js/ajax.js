// login register

$(document).ready(function () {
  // Check session status on page load
  checkSessionStatus();

  // Function to check session status
  function checkSessionStatus() {
    $.ajax({
      url: '/db_2/backend/check_session.php', // PHP file that checks session status
      type: 'GET',
      dataType: 'json', // Expect JSON response
      success: function (response) {
        // Update content based on session status
        if (response.loggedIn) {
          $('#session-container').html('<a href="/db_2/frontend/index.html" id="logout"> '+  response.userDetails.username.toUpperCase() + '</a>');
          $('#login-register-container').hide();
          $('#loginDropdown').hide();
        } else {
          $('#session-container').html('');
          $('#login-register-container').show();
          $('#loginDropdown').show();
        }
      }
    });
  }



// Validaciones
  function validemail(email) {

//var emailFilter=/^[a-zA-Z0-9_.-]+@[a-z0-9][a-z0-9\-]{1,64}(\.[a-z]{2,4}|[a-z]{2,3}\.[a-z]{2})$/i; 

  var emailFilter=/^[a-zA-Z0-9_.-]+@[a-z0-9][a-z0-9\-]{1,64}((\.[a-z]{2,4}|[a-z]{2,3}\.[a-z]{2})|(\.[a-z]{2,4}\.[a-z]{2}))$/i; 



var validEmail=emailFilter.test(email); 



    if (validEmail!=false) { 

        //alert('Mail valido');

       return true;

    } 

    else { 

       // alert('Mail no valido');

       return false;

    }

    //alert('Oops!\n'+email);  

}// fin validmail



/*

Función para validar mail

*/

function validespacios(user) {

//var emailFilter=/^[a-zA-Z0-9_.-]+@[a-z0-9][a-z0-9\-]{1,64}(\.[a-z]{2,4}|[a-z]{2,3}\.[a-z]{2})$/i; 

//alert("valida sin espacios");

user = $.trim(user);



var userFilter=/^[a-zA-Z0-9]{4,15}$/i; 

//var userfilter=/^[a-zA-Z0-9]{1,10}$/i; 



var validuser=userFilter.test(user); 



    if (validuser!=false) { 

        //alert('valido');

       return true;

    } 

    else { 

       //alert('no valido');

       return false;

    }

    //alert('Oops!\n'+email);  



}// fin validsinespacios




  // fin validaciones






  // Form submission handlers
$('#register-form').submit(function (event) {
  event.preventDefault();

  // Get the input values
  var username = $('#username').val();
  var email = $('#email').val();
  var password = $('#password').val();
  var department = $('#department').val(); // Assuming 'department' is the name attribute in the form

  // Validate username and email
  if (!validespacios(username)) {
    alert('Invalid username. Please enter a valid username without spaces.');
    return;
  }

  if (!validemail(email)) {
    alert('Invalid email. Please enter a valid email address.');
    return;
  }

  // Get the captcha code entered by the user
  var enteredCaptcha = $('#captcha').val();

  // Validate the captcha using AJAX
  $.ajax({
    url: '/db_2/backend/validate_captcha.php',
    type: 'POST',
    data: { captcha: enteredCaptcha },
    success: function (response) {
      if (response === 'success') {
        // Captcha is valid, proceed with registration
        // Serialize the form data
        var formData = $('#register-form').serialize();

        // Submit registration form
        $.ajax({
          url: '/db_2/backend/register.php',
          type: 'POST',
          data: formData,
          success: function (data) {
            console.log(data); // Log the response for debugging
            // After registration, re-check the session status
            document.location.href = '/db_2/frontend/index.html';
            checkSessionStatus();
          }
        });
      } else {
        alert('Invalid Captcha. Please try again.');
        // Reload captcha image
        $('img[src="/db_2/backend/captcha.php"]').attr('src', '/db_2/backend/captcha.php?' + new Date().getTime());
      }
    }
  });
});


// $(document).ready(function () {
//   $('#login-form').submit(function (e) {
//     e.preventDefault();

//     // Get the captcha code entered by the user
//     var enteredCaptcha = $('#captcha').val();

//     // Validate the captcha using AJAX
//     $.ajax({
//       url: '/db_2/backend/validate_captcha.php',
//       type: 'POST',
//       data: { captcha: enteredCaptcha },
//       success: function (response) {
//         if (response === 'success') {
//           // Captcha is valid, proceed with login
//           // Serialize the form data
//           var formData = $('#login-form').serialize();

//           $.ajax({
//             url: '/db_2/backend/login.php',
//             type: 'POST',
//             data: formData,
//             success: function (data) {
//               console.log(data);

//               // Check if login was successful
//               if (data === 'success') {
//                 // After successful login, re-check the session status
//                 document.location.href = '/db_2/frontend/index.html';
//                 checkSessionStatus();
//               } else {
//                 // Handle unsuccessful login
//                 alert('Invalid credentials. Please try again.');
//                 // Reload captcha image
//                 $('img[src="/db_2/backend/captcha.php"]').attr('src', '/db_2/backend/captcha.php?' + new Date().getTime());
//               }
//             }
//             
//           });
//         } else {
//           // Handle invalid captcha
//           alert('Invalid Captcha. Please try again.');
//           // Reload captcha image
//           $('img[src="/db_2/backend/captcha.php"]').attr('src', '/db_2/backend/captcha.php?' + new Date().getTime());
//         }
//       }
//     });
//   });
// });



$(document).ready(function () {
  $('#login-form').submit(function (e) {
    e.preventDefault();

    // Get the captcha code entered by the user
    var enteredCaptcha = $('#captcha').val();

    // Validate the captcha using AJAX
    $.ajax({
      url: '/db_2/backend/validate_captcha.php',
      type: 'POST',
      data: { captcha: enteredCaptcha },
      success: function (response) {
        if (response === 'success') {
          // Captcha is valid, proceed with login
          // Serialize the form data
          var formData = $('#login-form').serialize();

          $.ajax({
            url: '/db_2/backend/login.php',
            type: 'POST',
            data: formData, // Use the serialized form data
            success: function (data) {
              console.log(data);
              // After login, re-check the session status
              document.location.href = '/db_2/frontend/index.html';
              checkSessionStatus();
            }
          });
        } else {
          alert('Invalid Captcha. Please try again.');
          // Reload captcha image
          $('img[src="/db_2/backend/captcha.php"]').attr('src', '/db_2/backend/captcha.php?' + new Date().getTime());
        }
      }
    });
  });
});





  // $('#login-form').submit(function (event) {
  //   event.preventDefault();
  // });

  // Logout click handler
  $(document).on('click', '#logout', function (event) {
    event.preventDefault();
    $.ajax({
      url: '/db_2/backend/logout.php',
      type: 'GET',
      success: function (data) {
        console.log(data); // Log the response for debugging
        // After logout, re-check the session status
        document.location.href='/db_2/frontend/index.html';
        checkSessionStatus();
      }
    });
  });


  $(document).ready(function() {
    // Abre el desplegable solo con clic en el botón
    $('#loginDropdown').click(function() {
      $('.dropdown-menu').toggle();
    });

    // Cierra el desplegable al hacer clic fuera de él o después de iniciar sesión
    $(document).click(function(e) {
      if (!$(e.target).closest('.dropdown').length && !$(e.target).closest('.dropdown-menu').length) {
        $('.dropdown-menu').hide();
      }
    });

    // Ejemplo de cierre del desplegable después de iniciar sesión (simulado)
    $('#login-form').submit(function(e) {
      // Aquí debes realizar tu lógica real de inicio de sesión
      // Actualmente, el código simula el cierre del desplegable después de enviar el formulario
      e.preventDefault();
      $('.dropdown-menu').hide();
    });

    $('#register-form').submit(function(e) {
      // Aquí debes realizar tu lógica real de inicio de sesión
      // Actualmente, el código simula el cierre del desplegable después de enviar el formulario
      e.preventDefault();
      $('.dropdown-menu').hide();
    });
    // Scroll to the bottom of the page on page load
    $(document).ready(function() {
      $('html, body').animate({ scrollTop: $(document).height()/2.5 }, 'slow');
    });






  });
});


function fetchDepartments() {
  $.ajax({
    url: '/db_2/backend/fetch_departments.php', // Replace with the actual PHP file to fetch departments
    type: 'GET',
    dataType: 'json',
    success: function (data) {
      // Populate the dropdown with fetched departments
      var departmentDropdown = $('#department');
      departmentDropdown.empty();
      $.each(data, function (index, department) {
        departmentDropdown.append('<option value="' + department.DepartmentID + '">' + department.DepartmentName + '</option>');
      });
    },
    error: function () {
      console.error('Error fetching departments');
    }
  });
}

// Fetch departments when the page loads
$(document).ready(function () {
  fetchDepartments();
});





// chats
//
// Función para cargar dinámicamente los cursos
function load_User_Courses() {
  $.ajax({
    url: '/db_2/backend/get_user_courses.php', // Cambia esto al nombre de tu script PHP que obtiene los cursos
    type: 'GET',
    success: function(data) {
      $('#course').html(data);
    }
  });
}





// Función para cargar el contenido del chat




function loadChat() {
  var selectedCourse = $('#course').val();
  if (selectedCourse) {
    // Ocultar el área de selección y mostrar el área del chat
    $('#courseSelection').hide();
    $('#chatContainer').show();

    // Establecer el valor del campo oculto con el ID del curso seleccionado
    $('#courseID').val(selectedCourse);

    // Cargar los posts del chat
    loadChatPosts(selectedCourse);
  } else {
    alert('Por favor, selecciona un curso antes de ingresar al chat.');
  }
}

// Función para cargar los posts del chat desde el servidor
function loadChatPosts(courseID) {
  $.ajax({
    url: '/db_2/backend/get_posts.php', // Cambia esto al nombre de tu script PHP que obtiene los posts
    type: 'GET',
    data: { courseID: courseID },
    success: function(data) {
      $('#chatContent').html(data);
    }
  });
}

function publishPost() {
  var content = $('#postContent').val();
  var courseID = $('#course').val();

  $.ajax({
    url: '/db_2/backend/publish_post.php',
    type: 'POST',
    data: { content: content, courseID: courseID },
    success: function(response) {
      alert('Post publicado correctamente.');
      // Recarga la lista de posts después de publicar.
      loadChat();
    }
  });
}

function editPost(postID) {
  var postElement = $("#post_" + postID);
  var currentContent = postElement.find(".content").text().trim();

  var newContent = prompt("Edit the post content:", currentContent);

  if (newContent !== null) {
    $.ajax({
      url: '/db_2/backend/edit_post.php',
      type: 'POST',
      data: { postID: postID, content: newContent },
      success: function(response) {
        postElement.find(".content").text(newContent);

        alert('Post content edited successfully.');
      }
    });
  }
}

function deletePost(postID) {
  if (confirm("Are you sure you want to delete this post?")) {
    $.ajax({
      url: '/db_2/backend/delete_post.php',
      type: 'POST',
      data: { postID: postID },
      success: function(response) {
        alert('Post deleted successfully.');
        // Reload the list of posts after deletion.
        loadChat();
      }
    });
  }
}





// department courses




function load_Dep_Courses() {
  $.ajax({
    url: '/db_2/backend/get_dep_courses.php', // Ruta al script PHP que obtiene los cursos
    type: 'GET',
    dataType: 'json',
    success: function(data) {
      var select = $('#dep_courses');
      $.each(data, function(index, course) {
        select.append($('<option>', {
          value: course.id,
          text: course.name
        }));
      });
    }
  });
}

function enroll() {
  var selectedCourse = $('#dep_courses').val();

  if (selectedCourse) {
    $.ajax({
      url: '/db_2/backend/enroll.php', // Ruta al script PHP que maneja la inscripción
      type: 'POST',
      data: { enroll: true, courses: [selectedCourse] },
      success: function(response) {
        alert(response);
        // Puedes redirigir al estudiante al chat o a la página principal después de la inscripción.
        // window.location.href = '/chat.html?course=' + selectedCourse;
      }
    });
  } else {
    alert('Por favor, selecciona un curso antes de inscribirte.');
  }
}


// document ready
$(document).ready(function() {
  load_Dep_Courses();
  load_User_Courses();
});
