// Generated by CoffeeScript 1.4.0
var Card,Column,Page;Card=function(e){return this.description=e,this},Column=function(e,t){var n=this;return this.cards=t,this.title=ko.observable(e),this.addCard=function(){return n.cards.push(new Card("Please add details"))},this},Page=function(e){return this.columns=e,this},$(function(){var e,t,n,r,i,s,o;return s=ko.observableArray(),n=ko.observableArray(),i=ko.observableArray(),o=new Column("Todo",s),t=new Column("Doing",n),r=new Column("Done",i),e=ko.observableArray([o,t,r]),window.page=new Page(e),ko.applyBindings(page)});