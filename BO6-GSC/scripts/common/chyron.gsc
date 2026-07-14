/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\chyron.gsc
**************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace chyron;

function private autoexec __init__system__() {
  system::register(#"chyron", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_a7e31c93e0e58929();
}

function private function_a7e31c93e0e58929() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_set("\a^\x87\xd8p[\x8d\xd1\xec\xb1\xa8)g\xb77L0U");
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  chyron_widget = hud_management::function_a1a13273e72bfe46("\x82B\xd9\x8a\xd4I\xf2\xe0\xa7%]\xa7\x97Q\xc2\xa4\b\xbe\x91\x10p\xb3");

  if(!isDefined(chyron_widget)) {
    assertmsg("<dev string:x24>" + "<dev string:x59>" + "<dev string:x73>");
  }

  mapinfo = function_cbe75068ad1ba418();

  if(!isDefined(mapinfo)) {
    return;
  }

  level.chyron_data = spawnStruct();
  level.chyron_data.widget = chyron_widget;
  level.chyron_data.chyrons = [];

  if(isDefined(mapinfo.chyrons) && mapinfo.chyrons.size > 0) {
    for(i = 0; i < mapinfo.chyrons.size; i++) {
      chyron_data = mapinfo.chyrons[i];
      bundle = "z\x1f\xf14\xc1\xc0*" + chyron_data.chyron;
      bundle_data = getscriptbundle(bundle);
      level.chyron_data.chyrons[chyron_data.reference] = bundle_data;
    }
  }

  ui::lui_registercallback("Z\x856\xd1\xfd\x1d\xa5\n\xc1\xc9\x15\xf5L\xfce\x8c\xe4\x84\x85\x9f", &hide_chyron);
  level utility::flag_set("\xc6\x1a^N{\x9bn\xfa\xb47\xd2\xe8\xb4\x166\xb4\xe9+\xc8");
}

function show_chyron(var_b9a8bcda87a48d4f, delay_reveal_chyron_line, delay_hide_chyron, var_ddc8bd1431f92807, var_63e055222f00cd78, var_af3c2f2fa5a1305d = 1) {
  level utility::flag_wait("\xc6\x1a^N{\x9bn\xfa\xb47\xd2\xe8\xb4\x166\xb4\xe9+\xc8");

  if(!(isDefined(level.chyron_data) && isDefined(level.chyron_data.chyrons))) {
    assertmsg("<dev string:xba>" + getDvar(@ "ui_mapname") + "<dev string:xf1>");
    return;
  }

  level.chyron_data.var_af3c2f2fa5a1305d = var_af3c2f2fa5a1305d;

  if(!isDefined(var_b9a8bcda87a48d4f)) {
    chyron_index = 0;
  } else {
    chyron_data = level.chyron_data.chyrons[var_b9a8bcda87a48d4f];
    assert(isDefined(chyron_data), "<dev string:x12f>" + var_b9a8bcda87a48d4f + "<dev string:x14d>");
    chyron_index = -1;

    foreach(chyron in level.chyron_data.chyrons) {
      chyron_index++;

      if(var_b9a8bcda87a48d4f == key) {
        break;
      }
    }
  }

  hud_management::function_35924dfcb78711f4("\x9f\b\x17@\x88\xdf\xef\xb1\xe7U\xc8\xd8\x11[", level.chyron_data.widget);

  if(!isDefined(var_ddc8bd1431f92807)) {
    var_ddc8bd1431f92807 = 100;
  }

  if(!isDefined(var_63e055222f00cd78)) {
    var_63e055222f00cd78 = -60;
  }

  hud_management::function_85d8a0ba2e35b6f2("\x9f\b\x17@\x88\xdf\xef\xb1\xe7U\xc8\xd8\x11[", var_ddc8bd1431f92807, var_63e055222f00cd78, 0, 2, 1);
  fields = [];
  fields["\x12\xb0!\xf7Z\x98q\xe7\xb5^Y\x9a"] = chyron_index;
  fields["\xcf\x0f\xff\xba\x96~\xb8\xe47\xafT\xc1\xca@\xf8b\x04\xd4T2r3\xa9\xf1"] = delay_reveal_chyron_line ?? 0.5;
  fields["\x91\x95\x1b\v^\xaf\x86\x96\x19Y\xd7cC\xbc\x9c\xbd\xe6"] = delay_hide_chyron ?? 3;
  hud_management::function_41ff479ac45608d6("\x9f\b\x17@\x88\xdf\xef\xb1\xe7U\xc8\xd8\x11[", fields);
  setomnvar("\xc0\xdd\xad\x024\xa9\xb4o\x92`\x12\x14", 1);
  level notify("3\x1b\x80\r\x8b\xac\xc3p\x9c./1");
}

function hide_chyron(val) {
  hud_management::scripted_widget_destroy("\x9f\b\x17@\x88\xdf\xef\xb1\xe7U\xc8\xd8\x11[");

  if(level.chyron_data.var_af3c2f2fa5a1305d) {
    val::reset_all("\x9f\b\x17@\x88\xdf\xef\xb1\xe7U\xc8\xd8\x11[");
  }

  setomnvar("\xc0\xdd\xad\x024\xa9\xb4o\x92`\x12\x14", 0);
  level notify("u\b\x89\x7f\xe5\aX.*s\xa3\xe7p");
}