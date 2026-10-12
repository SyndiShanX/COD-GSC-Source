/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hud_popup.gsc
***********************************************/

#namespace hud_popup;

function init() {
  level.var_ace3e1c42c4a94d7 = [];
}

function function_65336cc44771776e(ref) {
  assert(isPlayer(self));
  popupid = function_bec00f5eabdb65ea(ref);

  if(!isDefined(popupid) || popupid < 0) {
    assertmsg("<dev string:x1c>" + ref + "<dev string:x41>" + function_92b0a87f4e1a1d72());
    return;
  }

  self setclientomnvar("ui_player_popup_id", popupid);
  self.lastpopuptime = gettime();
  self.var_942b501d544b0e0a = ref;

  debugpopup(popupid);
}

function function_233461f36bb50ef9(ref) {
  assert(isPlayer(self));

  if(isDefined(ref)) {
    popupid = function_bec00f5eabdb65ea(ref);

    if(self getclientomnvar("ui_player_popup_id") != popupid) {
      return;
    }
  }

  self setclientomnvar("ui_player_popup_id", -1);

  if(getdvarint(@ "hash_e2743b22a86111f", 1) == 1) {
    level notify("<dev string:x60>");
  }
}

function function_bec00f5eabdb65ea(popupref) {
  id = level.var_ace3e1c42c4a94d7[popupref];

  if(!isDefined(id)) {
    id = tablelookuprownum(function_92b0a87f4e1a1d72(), 0, popupref);
    level.var_ace3e1c42c4a94d7[popupref] = id;
  }

  return id;
}

function function_92b0a87f4e1a1d72() {
  return getDvar(@ "hash_db7ab5886366dcda", "mp/infoPopupTable.csv");
}

function function_9b5e6384b2ba7ad8(popuptitle, popupdesc, popuptier, popupindex) {
  level endon("<dev string:x74>");
  level notify("<dev string:x60>");
  level endon("<dev string:x60>");
  var_b20c3f89f6901d7b = 6;
  starttime = gettime();

  while(gettime() - starttime < var_b20c3f89f6901d7b * 1000) {
    printtoscreen2d(750, 400, popuptitle, (1, 0, 0), 3);
    printtoscreen2d(750, 475, popupdesc, (1, 0, 0), 3);
    printtoscreen2d(750, 550, popuptier, (1, 0, 0), 3);
    printtoscreen2d(850, 550, popupindex, (1, 0, 0), 3);
    waitframe();
  }
}

function debugpopup(id) {
  if(getdvarint(@ "hash_e2743b22a86111f", 0) == 0) {
    return;
  }

  if(isbot(self)) {
    return;
  }

  popuptitle = tablelookupbyrow(function_92b0a87f4e1a1d72(), id, 1);
  popupdesc = tablelookupbyrow(function_92b0a87f4e1a1d72(), id, 2);
  popuptier = tablelookupbyrow(function_92b0a87f4e1a1d72(), id, 4);
  popupindex = tablelookupbyrow(function_92b0a87f4e1a1d72(), id, 5);
  level thread function_9b5e6384b2ba7ad8(popuptitle, popupdesc, popuptier, popupindex);
}

# /