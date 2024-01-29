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

  // Form submission handlers
  $('#register-form').submit(function (event) {
    event.preventDefault();
    $.ajax({
      url: '/db_2/backend/register.php',
      type: 'POST',
      data: $(this).serialize(),
      success: function (data) {
        console.log(data); // Log the response for debugging
        // After registration, re-check the session status
        document.location.href='/db_2/frontend/index.html';
        checkSessionStatus();


      }
    });
  });

  $('#login-form').submit(function (event) {
    event.preventDefault();
    $.ajax({
      url: '/db_2/backend/login.php',
      type: 'POST',
      data: $(this).serialize(),
      success: function (data) {
        console.log(data); // Log the response for debugging
        // After login, re-check the session status
        document.location.href='/db_2/frontend/index.html';
        checkSessionStatus();
      }
    });
  });

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
function loadCourses() {
  $.ajax({
    url: '/db_2/backend/test_cursos.php', // Cambia esto al nombre de tu script PHP que obtiene los cursos
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

// Función para enviar mensajes del chat
function sendChatMessage() {
  // ... código adicional para enviar mensajes del chat usando AJAX ...
}

// Cargar cursos al cargar la página
$(document).ready(function() {
  loadCourses();
});

