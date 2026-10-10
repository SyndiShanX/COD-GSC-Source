/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_68c9c628ce1ce624.gsc
*************************************************/

#using scripts\engine\utility;
#namespace namespace_8385be0808a3216c;

function function_96f86549e383586(player, var_efa963805ba84047) {
  player endon("death_or_disconnect");

  if(!isDefined(player)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(!isDefined(var_efa963805ba84047) || var_efa963805ba84047.size == 0) {
    assertmsg("<dev string:x38>");
    return;
  }

  for(i = 0; i < var_efa963805ba84047.size; i++) {
    vfx = var_efa963805ba84047[i];
    wait vfx.var_da3878c8f78d9c9c;

    if(vfx.type == "nade") {
      if(vfx.weaponname == "explosion") {
        if(!isarray(vfx.startlocation) && !isvector(vfx.startlocation)) {
          vfx.startlocation = (0, 0, 0);
        }

        radiusdamage(vfx.endlocation, scripts\engine\utility::ter_op(vfx.startlocation[0] > 0, vfx.startlocation[0], 100), scripts\engine\utility::ter_op(vfx.startlocation[1] > 0, vfx.startlocation[1], 500), scripts\engine\utility::ter_op(vfx.startlocation[2] > 0, vfx.startlocation[2], 500), player, "MOD_EXPLOSIVE", "c4_mp");
      } else {
        player launchgrenade(vfx.weaponname, vfx.endlocation, (0, 0, 0), 0.05);
      }

      continue;
    }

    if(vfx.type == "missile") {
      magicbullet(vfx.weaponname, vfx.startlocation, vfx.endlocation);
    }
  }
}

function function_5842ae542da36283(var_34ef5453effff2cf) {
  var_c0f4e5221bf034f0 = [];

  foreach(vfx_array in var_34ef5453effff2cf) {
    assertex(vfx_array.size == 5, "<dev string:x53>");
    assertex(isstring(vfx_array[0]) && (vfx_array[0] == "<dev string:xc2>" || vfx_array[0] == "<dev string:xca>"), "<dev string:xd5>");
    assertex(isstring(vfx_array[1]), "<dev string:xf3>");
    assertex(isvector(vfx_array[2]) || vfx_array[2] == 0, "<dev string:x118>");
    assertex(isvector(vfx_array[3]), "<dev string:x140>");
    assertex(isnumber(vfx_array[4]), "<dev string:x166>");
    type = vfx_array[0];
    weaponname = vfx_array[1];
    startposition = undefined;
    endposition = vfx_array[3];
    var_da3878c8f78d9c9c = vfx_array[4];

    if(vfx_array[2] != 0) {
      startposition = vfx_array[2];
    }

    var_c0f4e5221bf034f0[var_c0f4e5221bf034f0.size] = function_8763c8d36e19655e(type, weaponname, startposition, endposition, var_da3878c8f78d9c9c);
  }

  return var_c0f4e5221bf034f0;
}

function private function_8763c8d36e19655e(type, weaponname, startlocation, endlocation, var_da3878c8f78d9c9c) {
  vfx_struct = spawnStruct();
  vfx_struct.endlocation = endlocation;
  vfx_struct.startlocation = startlocation;
  vfx_struct.type = type;
  vfx_struct.weaponname = weaponname;
  vfx_struct.var_da3878c8f78d9c9c = var_da3878c8f78d9c9c;
  return vfx_struct;
}

function function_75e0c9d28c4fa84b(player, var_c693843d9c5bf5b6) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x189>");
    return 0;
  }

  if(function_33bec7768bb73450()) {
    assertmsg("<dev string:x1bc>");
    return 0;
  }

  level.var_48bf03bfbb560f3b = 1;
  level.var_4775f352c850b592 = [];
  level.var_4a94dc5bca439216 = [];
  level.var_bb6e6442e6da34b = 0;
  level.var_73c61c58987fd970 = [];
  thread function_4f722a686a06493c(player);
  thread function_eb5970b251e2fa0f(player);
  thread function_61f3ce164ef1f960(player);
  iprintlnbold("<dev string:x1fd>");

  if(istrue(var_c693843d9c5bf5b6)) {
    function_8115586fea394e7b(player);
  }

  return 1;
}

function function_5e87edc0b6c7f8d9() {
  if(!function_33bec7768bb73450()) {
    assertmsg("<dev string:x216>");
    return 0;
  }

  level.var_48bf03bfbb560f3b = 0;
  level.var_4775f352c850b592 = [];
  level.var_2ee583ece91088aa = [];
  level.var_bb6e6442e6da34b = 0;
  level notify("<dev string:x256>");
  iprintlnbold("<dev string:x267>");
  return 1;
}

function function_33bec7768bb73450() {
  return istrue(level.var_48bf03bfbb560f3b);
}

function function_420969790027e6f() {
  return isDefined(level.var_4a94dc5bca439216) && level.var_4a94dc5bca439216.size > 0;
}

function function_4768d80bee0f64ae() {
  if(!function_420969790027e6f()) {
    return 0;
  }

  return level.var_4a94dc5bca439216.size;
}

function function_e8683d8412fba24f(player, var_aa9604938f87117c) {
  if(!isDefined(var_aa9604938f87117c)) {
    var_aa9604938f87117c = undefined;
  }

  if(!function_33bec7768bb73450()) {
    assertmsg("<dev string:x27f>");
    return;
  }

  if(!function_420969790027e6f()) {
    assertmsg("<dev string:x2b6>");
    return;
  }

  force_index = 0;

  if(!isDefined(var_aa9604938f87117c) || !isDefined(level.var_4a94dc5bca439216[var_aa9604938f87117c])) {
    if(isDefined(var_aa9604938f87117c) && !isDefined(level.var_4a94dc5bca439216[var_aa9604938f87117c])) {
      assertmsg("<dev string:x2d3>" + var_aa9604938f87117c + "<dev string:x2e5>");
      return;
    }

    var_aa9604938f87117c = level.var_bb6e6442e6da34b;
  } else {
    force_index = 1;
  }

  thread function_96f86549e383586(player, level.var_4a94dc5bca439216[var_aa9604938f87117c]);

  if(!force_index) {
    level.var_bb6e6442e6da34b = (level.var_bb6e6442e6da34b + 1) % level.var_4a94dc5bca439216.size;
  }
}

function function_a214d0f4e69fa9d7() {
  function_6e12d04e80eb8e63("<dev string:x320>");
}

function function_135f9f255157ecd6(callback) {
  if(!isDefined(level.var_73c61c58987fd970)) {
    level.var_73c61c58987fd970 = [];
  }

  level.var_73c61c58987fd970[level.var_73c61c58987fd970.size] = callback;
}

function private function_4f722a686a06493c(player) {
  level endon("<dev string:x256>");
  level endon("<dev string:x337>");
  player endon("<dev string:x345>");
  default_x = 20;
  var_f3447b872570129d = 250;
  scale = 1.3;
  color = (0, 1, 0);

  for(;;) {
    origin = player.origin;
    x = scripts\engine\utility::string(origin[0]);
    y = scripts\engine\utility::string(origin[1]);
    z = scripts\engine\utility::string(origin[2]);
    printtoscreen2d(default_x, var_f3447b872570129d, "<dev string:x35e>" + x + "<dev string:x374>" + y + "<dev string:x374>" + z + "<dev string:x37a>", color, scale, 1);
    angles = player.angles;
    angles_x = scripts\engine\utility::string(angles[0]);
    angles_y = scripts\engine\utility::string(angles[1]);
    angles_z = scripts\engine\utility::string(angles[2]);
    printtoscreen2d(default_x, var_f3447b872570129d + 30, "<dev string:x380>" + angles_x + "<dev string:x374>" + angles_y + "<dev string:x374>" + angles_z + "<dev string:x37a>", color, scale, 1);
    var_f7e58d89de45c95d = scripts\engine\utility::ter_op(level.var_4a94dc5bca439216.size == 0, 0, level.var_bb6e6442e6da34b + 1);
    printtoscreen2d(default_x, var_f3447b872570129d + 60, "<dev string:x396>" + scripts\engine\utility::string(var_f7e58d89de45c95d) + "<dev string:x3b0>" + level.var_4a94dc5bca439216.size + "<dev string:x3b7>" + "<dev string:x3be>" + "<dev string:x3c3>", color, scale, 1);
    printtoscreen2d(default_x, var_f3447b872570129d + 100, "<dev string:x3e4>" + toupper("<dev string:x3fe>") + "<dev string:x404>", color, scale, 1);
    waitframe();
  }
}

function private function_eb5970b251e2fa0f(player) {
  level endon("<dev string:x256>");
  level endon("<dev string:x337>");
  player endon("<dev string:x345>");
  sphere_radius = 10;
  var_5dcdab91d656aac8 = sphere_radius * 0.5;

  for(;;) {
    if(getdvarint(@ "hash_e35e43cce7cf7506", 1) == 0 || !function_420969790027e6f()) {
      waitframe();
      continue;
    }

    foreach(vfx_array in level.var_4a94dc5bca439216) {
      foreach(index, vfx in vfx_array) {
        if(vfx.type == "<dev string:xca>") {
          sphere(vfx.startlocation, sphere_radius, (0, 1, 0), 0, 1);
          line(vfx.startlocation, vfx.endlocation, (0, 1, 0), 1, 0, 1);
        }

        sphere(vfx.endlocation, sphere_radius, (0, 1, 0), 0, 1);
        sphere(vfx.endlocation, var_5dcdab91d656aac8, (0, 1, 0), 0, 1);
        print3d(vfx.endlocation, scripts\engine\utility::string(index) + "<dev string:x40a>" + vfx.weaponname, (0, 1, 0), 1, 0.75, 1, 1);
      }
    }

    waitframe();
  }
}

function private function_61f3ce164ef1f960(player) {
  level endon("<dev string:x256>");
  level endon("<dev string:x337>");
  player endon("<dev string:x345>");
  buttondown = 0;
  var_ddab7b8531f97681 = 0;

  for(;;) {
    for(i = 0; i < level.var_4775f352c850b592.size; i++) {
      if(player buttonPressed("<dev string:x410>" + scripts\engine\utility::string(i + 1))) {
        if(!level.var_4775f352c850b592[i]) {
          thread function_e8683d8412fba24f(player, i);
        }

        level.var_4775f352c850b592[i] = 1;
        break;
      }

      level.var_4775f352c850b592[i] = 0;
    }

    if(player buttonPressed("<dev string:x3be>")) {
      if(!buttondown) {
        thread function_e8683d8412fba24f(player);
      }

      buttondown = 1;
    } else if(player buttonPressed("<dev string:x3fe>")) {
      if(!buttondown) {
        function_8115586fea394e7b(player);
      }

      buttondown = 1;
    } else if(buttondown) {
      buttondown = 0;
    }

    waitframe();
  }
}

function private function_8115586fea394e7b(player) {
  level.var_4a94dc5bca439216 = function_c7415e32aa23a545();
  level.var_bb6e6442e6da34b = 0;

  if(isDefined(level.var_73c61c58987fd970)) {
    foreach(callback in level.var_73c61c58987fd970) {
      thread[[callback]](player);
    }
  }
}

function private function_c7415e32aa23a545() {
  fileid = function_c2c645edfeb6c020("<dev string:x417>", "<dev string:x430>", "<dev string:x320>");
  filecontent = "<dev string:x438>";

  if(fileid == -1) {
    assertmsg("<dev string:x43c>");
  } else {
    filecontent = function_93dc0a43832de68c(fileid);
    fileid = function_e988d000f717c5aa(fileid);
  }

  fileid = function_c2c645edfeb6c020("<dev string:x417>", "<dev string:x467>", "<dev string:x320>");

  if(fileid == -1) {
    assertmsg("<dev string:x470>" + "<dev string:x320>" + "<dev string:x49e>" + "<dev string:x417>");
    return [];
  }

  fileid = function_e988d000f717c5aa(fileid);
  fileid = function_c2c645edfeb6c020("<dev string:x417>", "<dev string:x4a3>", "<dev string:x320>");

  if(fileid == -1) {
    assertmsg("<dev string:x470>" + "<dev string:x320>" + "<dev string:x49e>" + "<dev string:x417>");
    return [];
  }

  var_cb482a4d1ab8ec46 = "<dev string:x4ad>" + "<dev string:x4f6>" + "<dev string:x567>" + "<dev string:x5a6>" + "<dev string:x5cf>" + "<dev string:x3fe>" + "<dev string:x5da>" + "<dev string:x602>" + "<dev string:x681>" + "<dev string:x6d0>" + "<dev string:x6d5>" + "<dev string:x6e0>" + "<dev string:x6f0>" + "<dev string:x709>" + "<dev string:x718>" + "<dev string:x730>" + "<dev string:x73e>" + "<dev string:x752>" + "<dev string:x765>" + "<dev string:x77a>" + "<dev string:x794>" + "<dev string:x7a7>" + "<dev string:x7ba>" + "<dev string:x7cf>" + "<dev string:x7ee>" + "<dev string:x6d0>" + "<dev string:x87b>" + "<dev string:x889>" + "<dev string:x8a1>" + "<dev string:x8b7>" + "<dev string:x6d0>" + "<dev string:x8d2>" + "<dev string:x92d>" + "<dev string:x993>" + "<dev string:x9a2>" + "<dev string:x9df>" + "<dev string:xa3e>" + "<dev string:xa8d>" + "<dev string:xae3>" + "<dev string:x6d0>" + "<dev string:xb33>" + "<dev string:xb42>" + "<dev string:xb81>" + "<dev string:xbc0>" + "<dev string:xc04>" + "<dev string:xc44>" + "<dev string:x6d0>" + "<dev string:xc84>";
  function_a10a2a3a8856b602(fileid, var_cb482a4d1ab8ec46);
  var_908fb7cd714520c9 = "<dev string:xccb>";
  var_88f100313f3b096d = "<dev string:x438>";
  var_2606386fb5273aea = 0;

  for(i = 0; i < filecontent.size; i++) {
    if(filecontent[i] == "<dev string:xcd0>") {
      var_2606386fb5273aea = !var_2606386fb5273aea;
      continue;
    }

    if(!var_2606386fb5273aea) {
      var_88f100313f3b096d += filecontent[i];
    }
  }

  function_a10a2a3a8856b602(fileid, var_88f100313f3b096d);
  fileid = function_e988d000f717c5aa(fileid);
  currentline = "<dev string:x438>";
  var_83dbc5b05ae7eaf9 = [];

  for(i = 0; i < var_88f100313f3b096d.size; i++) {
    if((var_88f100313f3b096d[i] == "<dev string:x6d0>" || i == var_88f100313f3b096d.size - 1) && currentline != "<dev string:x438>" && currentline != "<dev string:x6d0>") {
      var_83dbc5b05ae7eaf9[var_83dbc5b05ae7eaf9.size] = currentline;
      currentline = "<dev string:x438>";
      continue;
    }

    currentline += var_88f100313f3b096d[i];
  }

  var_cf780a38f1ac0432 = [];
  vfx_structs = [];
  type = "<dev string:x438>";
  weapon_name = "<dev string:x438>";
  startposition = [];
  endposition = [];
  var_ec771b1feb322ffa = -1;
  tempstring = "<dev string:x438>";
  var_432a7c3e01871183 = 0;

  for(i = 0; i < var_83dbc5b05ae7eaf9.size; i++) {
    for(j = 0; j < var_83dbc5b05ae7eaf9[i].size; j++) {
      if(var_83dbc5b05ae7eaf9[i][j] == var_908fb7cd714520c9 && vfx_structs.size != 0) {
        var_cf780a38f1ac0432[var_cf780a38f1ac0432.size] = arraycopy(vfx_structs);
        vfx_structs = [];
        continue;
      }

      if(var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcd5>") {
        var_432a7c3e01871183 = 1;
        tempstring = "<dev string:x438>";
        continue;
      }

      if(!var_432a7c3e01871183) {
        continue;
      }

      if(type == "<dev string:x438>") {
        if(var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcda>") {
          type = tempstring;
          tempstring = "<dev string:x438>";
        } else {
          tempstring += var_83dbc5b05ae7eaf9[i][j];
        }
      } else if(weapon_name == "<dev string:x438>") {
        if(var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcda>") {
          weapon_name = tempstring;
          tempstring = "<dev string:x438>";
        } else {
          tempstring += var_83dbc5b05ae7eaf9[i][j];
        }
      } else if(startposition.size != 3) {
        if(var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcdf>" || var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcda>") {
          startposition[startposition.size] = float(tempstring);
          tempstring = "<dev string:x438>";
        } else {
          tempstring += var_83dbc5b05ae7eaf9[i][j];
        }
      } else if(endposition.size != 3) {
        if(var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcdf>" || var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcda>") {
          endposition[endposition.size] = float(tempstring);
          tempstring = "<dev string:x438>";
        } else {
          tempstring += var_83dbc5b05ae7eaf9[i][j];
        }
      } else if(var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcda>") {
        var_ec771b1feb322ffa = float(tempstring);
      } else {
        tempstring += var_83dbc5b05ae7eaf9[i][j];
      }

      if(var_83dbc5b05ae7eaf9[i][j] == "<dev string:xcda>") {
        var_432a7c3e01871183 = 0;
      }

      if(type != "<dev string:x438>" && weapon_name != "<dev string:x438>" && startposition.size == 3 && endposition.size == 3 && var_ec771b1feb322ffa != -1) {
        vfx_structs[vfx_structs.size] = function_8763c8d36e19655e(type, weapon_name, (startposition[0], startposition[1], startposition[2]), (endposition[0], endposition[1], endposition[2]), var_ec771b1feb322ffa);
        type = "<dev string:x438>";
        weapon_name = "<dev string:x438>";
        startposition = [];
        endposition = [];
        var_ec771b1feb322ffa = -1;
      }
    }
  }

  if(vfx_structs.size != 0) {
    var_cf780a38f1ac0432[var_cf780a38f1ac0432.size] = arraycopy(vfx_structs);
    vfx_structs = [];
  }

  iprintlnbold("<dev string:xce4>" + "<dev string:x417>" + "<dev string:xcfd>");
  level.var_4775f352c850b592 = [];

  for(i = 0; i < var_cf780a38f1ac0432.size; i++) {
    level.var_4775f352c850b592[level.var_4775f352c850b592.size] = 0;
  }

  return var_cf780a38f1ac0432;
}

# /