module Control.Asap.Browser where

foreign import data AsapForeign :: *

foreign import asap """
var asap = null; try {
var browserTest = window.location;
var global = window;
var rawAsap = function (task) {
    if (!queue.length) {
        requestFlush();
        flushing = true;
    }
    queue[queue.length] = task;
}
var queue = [];
var flushing = false;
var requestFlush;
var index = 0;
var capacity = 1024;
var flush = function() {
    while (index < queue.length) {
        var currentIndex = index;
        index = index + 1;
        queue[currentIndex].call();
        if (index > capacity) {
            for (var scan = 0; scan < index; scan++) {
                queue[scan] = queue[scan + index];
            }
            queue.length -= index;
            index = 0;
        }
    }
    queue.length = 0;
    index = 0;
    flushing = false;
}
var makeRequestCallFromMutationObserver = function(callback) {
    var toggle = 1;
    var observer = new BrowserMutationObserver(callback);
    var node = document.createTextNode("");
    observer.observe(node, {characterData: true});
    return function requestCall() {
        toggle = -toggle;
        node.data = toggle;
    };
}
var makeRequestCallFromTimer = function (callback) {
    return function requestCall() {
        var timeoutHandle = setTimeout(handleTimer, 0);
        var intervalHandle = setInterval(handleTimer, 50);
        function handleTimer() {
            // Whichever timer succeeds will cancel both timers and
            // execute the callback.
            clearTimeout(timeoutHandle);
            clearInterval(intervalHandle);
            callback();
        }
    };
}
rawAsap.makeRequestCallFromTimer = makeRequestCallFromTimer;

var BrowserMutationObserver = global.MutationObserver || global.WebKitMutationObserver;
if (typeof BrowserMutationObserver === "function") {
    requestFlush = makeRequestCallFromMutationObserver(flush);
} else {
    requestFlush = makeRequestCallFromTimer(flush);
}
rawAsap.requestFlush = requestFlush;


var freeTasks = [];
var pendingErrors = [];
var requestErrorThrow = rawAsap.makeRequestCallFromTimer(throwFirstError);
var throwFirstError = function() {
    if (pendingErrors.length) {
        throw pendingErrors.shift();
    }
}
asap = function asap(task) {
    var rawTask;
    if (freeTasks.length) {
        rawTask = freeTasks.pop();
    } else {
        rawTask = new RawTask();
    }
    rawTask.task = task;
    rawAsap(rawTask);
}
var RawTask = function() {
    this.task = null;
}
RawTask.prototype.call = function () {
    try {
        this.task.call();
    } catch (error) {
        if (asap.onerror) {
            asap.onerror(error);
        } else {
            pendingErrors.push(error);
            requestErrorThrow();
        }
    } finally {
        this.task = null;
        freeTasks[freeTasks.length] = this;
    }
};

var schedule = function(task) {
  return function() {
    asap(task);
  };
}
} catch (e) {}""" :: AsapForeign
