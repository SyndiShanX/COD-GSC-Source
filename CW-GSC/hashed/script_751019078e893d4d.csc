/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_751019078e893d4d.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace snd;

function private function_8f9218ba(hud) {
  if(isDefined(hud.var_ca1ec566)) {
    function_e23ba9aa(0, hud.var_ca1ec566, hud.var_708cbe39, "<dev string:x38>", hud.var_28f96332, hud.var_685ce76a);
    value = function_ea2f17d1(hud.value, 0);

    if(isDefined(value) && value > 0) {
      insize = hud.var_708cbe39 + (-2 * 2, -2 * 2, 0);
      inpos = hud.var_ca1ec566 + (2, 2, 0);

      if(hud.isvertical == 1) {
        inpos = hud.var_ca1ec566 + (2, 2 + insize[1], 0);
        insize = (insize[0], insize[1] * value, insize[2]);
        inpos -= (0, insize[1], 0);
      } else {
        insize = (insize[0] * value, insize[1], insize[2]);
      }

      function_e23ba9aa(0, inpos, insize, "<dev string:x38>", hud.var_4a70ec60, hud.var_e2c0fdcb);
    }
  }
}

function private function_20b6bc92() {
  assert(isDefined(level.var_a00c303b), "<dev string:x41>");
  level notify(#"hash_20f3988ee2416a3d");
  level endon(#"hash_20f3988ee2416a3d");
  level.var_a00c303b.mainthread = 1;

  while(isDefined(level.var_a00c303b)) {
    foreach(var_dfd5412c in level.var_a00c303b.objects) {
      if(isfunctionptr(var_dfd5412c.callbackfunc)) {
        target = var_dfd5412c.target;
        value = [[var_dfd5412c.callbackfunc]](target, var_dfd5412c.callbackdata, var_dfd5412c);
        function_fee448d5(var_dfd5412c, value);
      }

      function_8f9218ba(var_dfd5412c);
    }

    waitframe(1);
  }
}

function function_b009fcc9(x, y, w, h, target, callbackfunc, callbackdata, isvertical, backgroundcolor, backgroundalpha, var_a2dbe44f, var_6a3d8755) {
  isvertical = function_ea2f17d1(isvertical, 0);
  backgroundcolor = function_ea2f17d1(backgroundcolor, (0.72974, 0.72974, 0.72974));
  backgroundalpha = function_ea2f17d1(backgroundalpha, 0.72974);
  var_a2dbe44f = function_ea2f17d1(var_a2dbe44f, (0, 1, 0));
  var_6a3d8755 = function_ea2f17d1(var_6a3d8755, 0.72974);
  var_dfd5412c = spawnStruct();
  var_dfd5412c.isvertical = isvertical;
  var_dfd5412c.screenposition = array(x, y);
  var_dfd5412c.screensize = array(w, h);
  var_dfd5412c.var_ca1ec566 = (x, y, 0);
  var_dfd5412c.var_708cbe39 = (w, h, 0);
  var_dfd5412c.var_28f96332 = backgroundcolor;
  var_dfd5412c.var_685ce76a = backgroundalpha;
  var_dfd5412c.var_4a70ec60 = var_a2dbe44f;
  var_dfd5412c.var_e2c0fdcb = var_6a3d8755;
  var_dfd5412c.target = target;
  var_dfd5412c.callbackfunc = callbackfunc;
  var_dfd5412c.callbackdata = callbackdata;
  var_dfd5412c.var_c53c088d = gettime();
  var_fc6c677b = "white";

  hud = undefined;
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
    var_dfd5412c.valuehud = undefined;
  }

  if(isDefined(var_dfd5412c.var_8c127264)) {
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
  var_dfd5412c.value = value;

  if(value <= 0) {
    if(isDefined(var_dfd5412c.valuehud)) {
      var_dfd5412c.valuehud = undefined;
    }

    return;
  }
}