importScripts(
  "https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js",
);
importScripts(
  "https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js",
);

firebase.initializeApp({
  apiKey: "AIzaSyBUK2ge8jlP6jOqrPcMFrJebSv_oBDL5A0",
  authDomain: "evan-machine-store.firebaseapp.com",
  projectId: "evan-machine-store",
  storageBucket: "evan-machine-store.firebasestorage.app",
  messagingSenderId: "546996661047",
  appId: "1:546996661047:web:83807e710a1b8c193848b2",
});

const messaging = firebase.messaging();
