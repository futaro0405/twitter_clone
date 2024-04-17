import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["tabs", "contents"];

  initialize() {
    let tabs = this.tabsTarget;
    let contents = this.contentsTarget;

    function indexOfParent(node) {
      let children = node.parentNode.childNodes;
      let num = 0;

      for (var i=0; i<children.length; i++) {
          if (children[i]==node) return num;
          if (children[i].nodeType==1) num++;
      }
      return -1;
    }

    document.addEventListener("DOMContentLoaded", function(event) {
      let tabList = tabs.querySelectorAll(".nav-item");
      let contnetList = contents.querySelectorAll(".tab-pane");
      let activeNum = indexOfParent(tabs.querySelector('.active'));

      tabList[activeNum].classList.remove('active');
      contnetList[activeNum].classList.remove("show", "active");

      let sessionNum = sessionStorage.getItem('num');
      if (sessionNum !== null) {
        tabList[sessionNum].classList.add('active');
        contnetList[sessionNum].classList.add("show", "active");
      } else {
        tabList[0].classList.add('active');
        contnetList[0].classList.add("show", "active");
      }


      // if(sessionTab !== null || sessionContent !== null) {
      //   tabList[0].addClass('active');
      //   contentList[0].addClass('show active');
      // }else{

      // };

      // sessionStorage.setItem('tab', activeTabs);
      // sessionStorage.setItem('content', activeContents);
    },false);

  }

}
