document.addEventListener('DOMContentLoaded', (event) => {
  let sendForm = document.getElementById('send-email-form');
  let sendBtn = document.getElementById('send-email-btn');

  let checkForm = document.getElementById('check-email-form');
  let checkBtn = document.getElementById('check-email-btn');

  let updateForm = document.getElementById('update-password-form');
  let updateBtn = document.getElementById('update-password-btn');

  let updateMessage = document.getElementById('password-updated-message');

  if (sendBtn) {
    sendBtn.addEventListener('click', () => {
      if (sendForm && checkForm) {
        sendForm.style.display = 'none';
        checkForm.style.display = 'flex';
        console.log(
          'Formulário de envio ocultado; formulário de verificação exibido.',
        );
      } else {
        console.error('One or more elements (sendForm, checkForm) not found');
      }
    });
  } else {
    console.error('sendBtn not found');
  }

  if (checkBtn) {
    checkBtn.addEventListener('click', () => {
      console.log('Lógica para verificar o e-mail');
      if (checkForm && updateForm) {
        checkForm.style.display = 'none';
        updateForm.style.display = 'flex';
      } else {
        console.error('One or more elements (checkForm, updateForm) not found');
      }
    });
  } else {
    console.error('checkBtn not found');
  }

  if (updateBtn) {
    updateBtn.addEventListener('click', () => {
      console.log('Lógica para atualizar a senha');
      if (updateForm && updateMessage) {
        updateForm.style.display = 'none';
        updateMessage.style.display = 'flex';
      } else {
        console.error(
          'One or more elements (updateForm, updateMessage) not found',
        );
      }
    });
  } else {
    console.error('updateBtn not found');
  }
});
