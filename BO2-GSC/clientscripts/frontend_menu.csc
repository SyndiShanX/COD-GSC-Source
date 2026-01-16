/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\frontend_menu.csc
*******************************************/

#include clientscripts\_utility;

frontend_menu_init() {
  level.onsuimessage = ::onsuimessage;
  setup_ui3d();
  clients = getmaxlocalclients();

  for(i = 0; i < clients; i++) {
    if(localclientactive(i))
      forcegamemodemappings(i, "default");
  }

  luiload("T6.main");
  thread menu_auto_start();
}

setup_ui3d() {
  ui3dsetwindow(0, 0, 0, 0.5, 1);
  ui3dsetwindow(1, 0.5, 0, 0.5, 1);
  ui3dsetwindow(2, 0, 0, 0, 0);
  ui3dsetwindow(3, 0, 0, 0, 0);
  ui3dsetwindow(4, 0, 0, 0, 0);
  ui3dsetwindow(5, 0, 0, 0, 0);
}

menu_video_mapping() {
}

menu_auto_start() {
  localclientnum = 0;
  wait 1;
}

onsuimessage(localclientnum, param1, param2) {
  switch (param1) {
    case "ENABLE":
      break;
    case "DISABLE":
      break;
    case "BACKSPACE":
    case "BUTTON_RTRIG":
      if(param2 == "down") {
        if(!isluienabled(localclientnum))
          luienable(localclientnum, "main");
        else
          luidisable(localclientnum);
      }

      break;
  }
}