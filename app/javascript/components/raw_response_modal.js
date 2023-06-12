import { Modal } from 'bootstrap';

function openRawResponse(rawResponse) {
  var modal = new Modal(document.getElementById('rawResponseModal'));
  var iframe = document.getElementById('rawResponseIframe');
  iframe.srcdoc = rawResponse;
  modal.show();
}

function closeRawResponse() {
  var modal = Modal.getInstance(document.getElementById('rawResponseModal'));

  // Close the modal
  if (modal) {
    modal.hide();
  }
}

var closeButton = document.querySelector('#rawResponseModal .btn-close');
closeButton.addEventListener('click', closeRawResponse);

window.openRawResponse = openRawResponse;
