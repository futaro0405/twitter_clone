import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["tabs", "contents"];

  indexOfParent(node) {
    if (!node) {
      return -1;
    }

    let children = node.parentNode.childNodes;
    let num = 0;

    for (var i=0; i<children.length; i++) {
        if (children[i]==node) return num;
        if (children[i].nodeType==1) num++;
    }
    return -1;
  }

  initialize() {
    let tabs = this.tabsTarget;
    let contents = this.contentsTarget;
    let tabList = tabs.querySelectorAll(".nav-item");
    let contentList = contents.querySelectorAll(".tab-pane");

    function resetActive(tabsList, contentsList) {
      tabsList.forEach(tab => {
        tab.firstElementChild.classList.remove("active");
      });
      contentsList.forEach(content => {
        content.classList.remove("show", "active");
      });
    }

    function setActive() {
      let sessionNum = sessionStorage.getItem('num');
      if (sessionNum !== null) {
        tabList[sessionNum].firstElementChild.classList.add("active");
        contentList[sessionNum].classList.add("show", "active");
      } else {
        tabList[0].firstElementChild.classList.add("active");
        contentList[0].classList.add("show", "active");
      }
    }

    document.addEventListener("DOMContentLoaded", function(event) {
      resetActive(tabList, contentList);
      setActive();
    },false);
  }

  changetab() {
    let activeNum = indexOfParent(tabs.querySelector('.active'));
    sessionStorage.setItem('num', activeNum);

    resetActive(tabList, contentList);
    setActive();
  }

}
