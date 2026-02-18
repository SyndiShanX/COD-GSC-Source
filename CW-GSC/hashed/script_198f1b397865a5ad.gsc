/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_198f1b397865a5ad.gsc
***********************************************/

#using script_3dc93ca9902a9cda;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace snd;

function private function_20b6bc92() {
  assert(isDefined(level.var_a00c303b), "<dev string:x38>");
  level endon(#"hash_20f3988ee2416a3d");
  level.var_a00c303b.mainthread = 1;

  while(isDefined(level.var_a00c303b)) {
    foreach(var_dfd5412c in level.var_a00c303b.objects) {
      if(isfunctionptr(var_dfd5412c.callbackfunc)) {
        target = var_dfd5412c.target;
        value = [[var_dfd5412c.callbackfunc]](target, var_dfd5412c.callbackdata, var_dfd5412c);
        function_fee448d5(var_dfd5412c, value);
      }
    }

    waitframe(1);
  }
}

function function_b009fcc9(x, y, w, h, target, callbackfunc, callbackdata, isvertical, backgroundcolor, backgroundalpha, var_a2dbe44f, var_6a3d8755) {
  isvertical = function_ea2f17d1(isvertical, 0);
  backgroundcolor = function_ea2f17d1(backgroundcolor, 0.72974);
  backgroundalpha = function_ea2f17d1(backgroundalpha, 0.72974);
  var_a2dbe44f = function_ea2f17d1(var_a2dbe44f, (0, 1, 0));
  var_6a3d8755 = function_ea2f17d1(var_6a3d8755, 0.72974);
  var_dfd5412c = spawnStruct();
  var_dfd5412c.isvertical = isvertical;
  var_dfd5412c.screenposition = array(x, y);
  var_dfd5412c.screensize = array(w, h);
  var_dfd5412c.var_ca1ec566 = function_da7b7c0e(array(x, y));
  var_dfd5412c.var_708cbe39 = function_df9f894b(array(w, h));
  var_dfd5412c.var_4a70ec60 = var_a2dbe44f;
  var_dfd5412c.var_e2c0fdcb = var_6a3d8755;
  var_dfd5412c.target = target;
  var_dfd5412c.callbackfunc = callbackfunc;
  var_dfd5412c.callbackdata = callbackdata;
  var_dfd5412c.var_c53c088d = gettime();
  var_dfd5412c.var_ca1ec566 = array(var_dfd5412c.var_ca1ec566[0], var_dfd5412c.var_ca1ec566[1] - var_dfd5412c.var_708cbe39[1]);
  var_fc6c677b = "white";

  hud = newdebughudelem();
  hud.x = var_dfd5412c.var_ca1ec566[0];
  hud.y = var_dfd5412c.var_ca1ec566[1];
  hud.alignx = "<dev string:x5f>";
  hud.color = backgroundcolor;
  hud.alpha = backgroundalpha;
  hud.foreground = 0;
  hud.sort = -1;
  hud setshader(var_fc6c677b, var_dfd5412c.var_708cbe39[0], var_dfd5412c.var_708cbe39[1]);
  var_dfd5412c.var_8c127264 = hud;

  var_dfd5412c.valuehud = undefined;

  if(!isDefined(level.var_a00c303b)) {
    level.var_a00c303b = spawnStruct();
    level.var_a00c303b.objects = array();
  }

  level.var_a00c303b.objects[level.var_a00c303b.objects.size] = var_dfd5412c;

  if(!isDefined(level.var_a00c303b.mainthread)) {
    level.var_a00c303b thread function_20b6bc92();
  }

  return var_dfd5412c;
}

function function_9b4ec5ed(var_dfd5412c) {
  arrayremovevalue(level.var_a00c303b.objects, var_dfd5412c, 1);

  if(isDefined(var_dfd5412c.valuehud)) {
    var_dfd5412c.valuehud destroy();

    var_dfd5412c.valuehud = undefined;
  }

  if(isDefined(var_dfd5412c.var_8c127264)) {
    var_dfd5412c.var_8c127264 destroy();

    var_dfd5412c.var_8c127264 = undefined;
  }

  if(level.var_a00c303b.objects.size == 0) {
    level.var_a00c303b = undefined;
    level notify(#"hash_20f3988ee2416a3d");
  }
}

function function_fee448d5(var_dfd5412c, value) {
  now = gettime();

  if(isDefined(var_dfd5412c.var_c53c088d) && var_dfd5412c.var_c53c088d == now) {
    return;
  }

  value = math::clamp(float(value), 0, 1);
  var_dfd5412c.var_c53c088d = now;

  if(value <= 0) {
    if(isDefined(var_dfd5412c.valuehud)) {
      var_dfd5412c.valuehud destroy();

      var_dfd5412c.valuehud = undefined;
    }

    return;
  }

  var_ca1ec566 = array(var_dfd5412c.var_ca1ec566[0] + 1, var_dfd5412c.var_ca1ec566[1] + 1);
  var_708cbe39 = var_dfd5412c.var_708cbe39;

  if(var_dfd5412c.isvertical == 1) {
    height = var_dfd5412c.var_708cbe39[1] - 2;
    height *= value;
    var_708cbe39 = array(var_dfd5412c.var_708cbe39[0] - 2, int(ceil(height)));
    var_ca1ec566 = array(var_dfd5412c.var_ca1ec566[0] + 1, int(var_dfd5412c.var_ca1ec566[1] + var_dfd5412c.var_708cbe39[1] - var_708cbe39[1]) - 1);
  } else {
    width = var_dfd5412c.var_708cbe39[0] - 2;
    width *= value;
    var_708cbe39 = array(int(width), var_dfd5412c.var_708cbe39[1] - 2);
  }

  if(var_708cbe39[0] <= 0 || var_708cbe39[1] <= 0) {
    return;
  }

  if(!isDefined(var_dfd5412c.valuehud)) {
    hud = newdebughudelem();
    var_dfd5412c.valuehud = hud;
  }

  assert(isDefined(var_dfd5412c.valuehud));

  if(isDefined(var_dfd5412c.valuehud)) {
    var_fc6c677b = "white";

    var_dfd5412c.valuehud.x = var_ca1ec566[0];
    var_dfd5412c.valuehud.y = var_ca1ec566[1];
    var_dfd5412c.valuehud.alignx = "<dev string:x5f>";
    var_dfd5412c.valuehud.color = var_dfd5412c.var_4a70ec60;
    var_dfd5412c.valuehud.alpha = var_dfd5412c.var_e2c0fdcb;
    var_dfd5412c.valuehud.foreground = 0;
    var_dfd5412c.valuehud.sort = 1;
    var_dfd5412c.valuehud setshader(var_fc6c677b, var_708cbe39[0], var_708cbe39[1]);
  }
}

function private function_ef6f1667() {
  if(isDefined(level.var_25a33bf1) == 1) {
    return;
  }

  level.var_25a33bf1 = 1;

  while(isDefined(level.var_9c2f3e27) == 1) {
    now = gettime();
    var_4359175b = array();

    foreach(hud in level.var_9c2f3e27) {
      assert(function_3132f113(hud) == 0);

      if(hud.duration > 0) {
        var_4359175b[var_4359175b.size] = hud;

        if(hud.time == now) {
          continue;
        }

        hud.duration -= 1;

        if(hud.timeofdeath <= now) {
          hud.alpha = 0;
          hud settext("<dev string:x67>");
        }

        continue;
      }

      hud destroy();
    }

    level.var_9c2f3e27 = var_4359175b;
    waitframe(1);
  }
}

function private function_b506ee85(duration) {
  hud = undefined;
  now = gettime();
  timeofdeath = duration * 50;

  foreach(hud in level.var_9c2f3e27) {
    assert(function_3132f113(hud) == 0);

    if(now >= hud.timeofdeath) {
      hud.time = now;
      hud.timeofdeath = now + timeofdeath;
      hud.duration = duration;
      return hud;
    }
  }

  hud = newdebughudelem();
  hud.time = now;
  hud.timeofdeath = now + timeofdeath;
  hud.duration = duration;
  index = level.var_9c2f3e27.size;
  level.var_9c2f3e27[index] = hud;

  return hud;
}

function private function_2f282ca2(posx, posy, text, color, alpha, scale, duration) {
  hud_width = 640;
  hud_height = 480;
  var_b03b36b6 = hud_width / hud_height;
  var_1790a507 = function_827811b5();
  var_38c41a5e = var_1790a507[0];
  var_c13d121d = var_1790a507[1];
  var_60d4d877 = var_38c41a5e / var_c13d121d;
  widthoffset = -0.5 * (hud_height * var_60d4d877 - hud_width);
  hudx = posx / var_38c41a5e * hud_width + (1 - posx / var_38c41a5e * 0.5) * widthoffset;
  hudy = posy / var_c13d121d * hud_height;

  if(isDefined(level.var_9c2f3e27) == 0) {
    level.var_9c2f3e27 = array();
  }

  level thread function_ef6f1667();

  hud = function_b506ee85(duration);
  hud.x = hudx;
  hud.y = hudy;
  hud settext(text);
  hud.color = color;
  hud.alpha = alpha;
  hud.fontscale = scale * 0.5;
  hud.font = "<dev string:x6b>";
  hud.alignx = "<dev string:x5f>";
  hud.aligny = "<dev string:x79>";
  hud.var_eeaee6a5 = "<dev string:x83>";
  hud.vertalign = "<dev string:x83>";
  hud.xoffset = 0;
  hud.yoffset = 0;
  hud.xpadding = 0;
  hud.ypadding = 0;
}

function function_1f59f703(var_eb7d70a5) {
  if(isDefined(var_eb7d70a5) == 1 && var_eb7d70a5 != 0) {
    level.var_44a79f1b = &function_2f282ca2;
    return;
  }

  level.var_44a79f1b = undefined;
}