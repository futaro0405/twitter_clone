import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="previews"
export default class extends Controller {
  static targets = ["input", "preview"];
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  preview() {
    let input = this.inputTarget;
    let preview = this.previewTarget;
    let files = input.files;

    function readAndPreview(file) {
      let reader = new FileReader();
      reader.onload = ((e) => {
        let image = new Image();
        image.src = e.target.result;
        preview.appendChild(image);
      });
      reader.readAsDataURL(file);
    }

    if (files) {
      Array.prototype.forEach.call(files, readAndPreview);
    }
  }
}
