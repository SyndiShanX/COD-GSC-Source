/***************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\character_customization.csc
***************************************************/

#using scripts\core_common\activecamo_shared;
#using scripts\core_common\activecamo_shared_util;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace character_customization;
class class_7da27482 {
  var _angles;
  var _i_mode;
  var _origin;
  var _target_name;
  var _xuid;
  var var_180f1c7d;
  var var_1d18f5c7;
  var var_1d73bad9;
  var var_228f64da;
  var var_266b2ff0;
  var var_27af8d38;
  var var_37d425ec;
  var var_43b94d19;
  var var_444a0d45;
  var var_45210dc7;
  var var_506d3c33;
  var var_54430cb6;
  var var_5633914d;
  var var_5d01abf7;
  var var_609efd3e;
  var var_640fbaae;
  var var_6ce65c01;
  var var_7245a8e1;
  var var_81bd1932;
  var var_851003fe;
  var var_87449256;
  var var_8d2161e9;
  var var_8d79cdc7;
  var var_9896541c;
  var var_9a4a8ea;
  var var_9bea772f;
  var var_a287debe;
  var var_b3113387;
  var var_b627749c;
  var var_b6892e9d;
  var var_bf273e28;
  var var_bf4feef5;
  var var_c31e86ed;
  var var_cbcee022;
  var var_cf55444c;
  var var_cfe86a3e;
  var var_d47cfe9d;
  var var_d781e2e4;
  var var_e09268b7;
  var var_eb95665;
  var var_ef017bf9;
  var var_f141235b;
  var var_f5c0467b;
  var var_fa881a;
  var var_ff2bed36;

  constructor() {
    var_f141235b = 0;
    var_81bd1932 = 0;
    _xuid = undefined;
    _target_name = undefined;
    _i_mode = 1;
    var_1d73bad9 = 0;
    var_cf55444c = 0;
    var_cfe86a3e = 0;
    var_f5c0467b = [0, 0, 0, 0, 0, 0, 0, 0];
    assert(-1);
    var_228f64da = undefined;
    var_e09268b7 = undefined;
    var_43b94d19 = 1;
    var_c31e86ed = 0;
    var_b3113387 = 0;
    var_444a0d45 = 0;
    _origin = (0, 0, 0);
    _angles = (0, 0, 0);
    var_9a4a8ea = undefined;
    var_cbcee022 = undefined;
    var_54430cb6 = undefined;
    var_5d01abf7 = undefined;
    var_6ce65c01 = undefined;
    var_9bea772f = undefined;
    var_a287debe = undefined;
    var_8d2161e9 = 0;
    var_b6892e9d = 0;
    var_45210dc7 = [];
    var_bf273e28 = [];
    var_5633914d = [];
    var_eb95665 = undefined;
    var_b627749c = 1;
    var_27af8d38 = [];
    var_bf4feef5 = 1;
    var_609efd3e = 1;
    var_9896541c = 0;
    var_851003fe = 1;
    var_ef017bf9 = 0;
    var_d47cfe9d = 0;
    var_fa881a = 0;
    var_506d3c33 = [];
    var_ff2bed36 = undefined;
    var_8d79cdc7 = undefined;
    var_640fbaae = undefined;
    var_266b2ff0 = undefined;
    var_7245a8e1 = # "";
    var_d781e2e4 = undefined;
    var_180f1c7d = [];
    var_87449256 = undefined;
    var_1d18f5c7 = 0;
  }

  function function_878481() {
    if(isarray(var_37d425ec)) {
      foreach(n_fx_id in var_37d425ec) {
        if(isDefined(n_fx_id)) {
          deletefx(var_f141235b, n_fx_id);
        }
      }

      var_37d425ec = undefined;
    }
  }

  function function_47ad026() {
    if(var_1d18f5c7 && isDefined(var_cbcee022)) {
      var_228f64da thread animation::play(var_cbcee022, var_228f64da);
    }
  }

  function private function_c358189(model_name, lod = -1, mip = -1) {
    index = array::find(var_506d3c33, {
      #model: model_name, #lod: lod, #mip: mip
    }, &function_1a57b132);
    assert(isDefined(index));

    if(!isDefined(index)) {
      return 1;
    }

    return character_customization::function_c358189(model_name, lod, mip);
  }

  function is_streamed() {
    if(isDefined(var_228f64da)) {
      if(!var_228f64da isstreamed()) {
        return false;
      }
    }

    if(var_9896541c && function_d9aed86()) {
      return false;
    }

    foreach(ent in var_5633914d) {
      if(isDefined(ent)) {
        if(!ent isstreamed()) {
          return false;
        }
      }
    }

    return true;
  }

  function function_10b0cbea() {
    function_158505aa(function_76fbb09e(var_f141235b, _i_mode, var_1d73bad9));
  }

  function function_158505aa(outfit_index) {
    assert(_i_mode != 4);
    var_cfe86a3e = outfit_index;
  }

  function function_15a8906a(var_23904c1d) {
    if(isDefined(var_23904c1d.xuid)) {
      set_xuid(var_23904c1d.xuid);
    }

    set_character_mode(var_23904c1d.charactermode);
    set_character_index(var_23904c1d.charactertype);
    set_character_outfit(var_23904c1d.outfit);
    function_158505aa(var_23904c1d.warpaintoutfit);
    assert(var_23904c1d.outfititems.size == 8);

    foreach(itemtype, itemindex in var_23904c1d.outfititems) {
      set_character_outfit_item(itemindex, itemtype);
    }
  }

  function function_184a4d2e(callback_fn) {
    if(!isDefined(var_180f1c7d)) {
      var_180f1c7d = [];
    } else if(!isarray(var_180f1c7d)) {
      var_180f1c7d = array(var_180f1c7d);
    }

    if(!isinarray(var_180f1c7d, callback_fn)) {
      var_180f1c7d[var_180f1c7d.size] = callback_fn;
    }
  }

  function function_1978bfeb() {
    if(var_c31e86ed) {
      return # "tag_origin";
    }

    return character_customization::function_6bca50af(&function_6b7000e, var_1d73bad9, var_cf55444c, var_f5c0467b[3], _i_mode);
  }

  function private function_1a57b132(data_1, data_2) {
    return data_1.model === data_2.model && data_1.lod === data_2.lod && data_1.mip === data_2.mip;
  }

  function function_1d4afc32() {
    return var_d47cfe9d;
  }

  function function_1ec9448d(var_6ef2ca20) {
    if(var_6ef2ca20 != var_c31e86ed) {
      var_c31e86ed = var_6ef2ca20;
      var_b627749c = 1;
    }
  }

  function function_1f70adfe() {
    return var_6ce65c01;
  }

  function private function_217b10ed() {
    return var_228f64da;
  }

  function function_22039feb() {
    set_character_outfit(0);
    function_158505aa(0);
    function_95779b72();
  }

  function update(params) {
    self thread update_internal(params);
  }

  function function_225b6e07() {
    var_65496229 = function_690c9509();
    character_index = getequippedheroindex(var_65496229, _i_mode);
    set_character_index(character_index);
  }

  function get_character_mode() {
    return _i_mode;
  }

  function function_25725c05() {
    return _xuid;
  }

  function function_27945cb8(on_off, force = 0) {
    if(var_b3113387 != on_off || force) {
      var_b3113387 = on_off;
      function_2a5421e3();
    }
  }

  function private function_2a5421e3() {
    if(var_b3113387 && !var_228f64da function_d2503806(#"hash_79892e1d5a8f9f33")) {
      var_228f64da playrenderoverridebundle(#"hash_79892e1d5a8f9f33");
      return;
    }

    if(!var_b3113387 && var_228f64da function_d2503806(#"hash_79892e1d5a8f9f33")) {
      var_228f64da stoprenderoverridebundle(#"hash_79892e1d5a8f9f33");
    }
  }

  function set_alt_render_mode(alt_render_mode) {
    var_bf4feef5 = alt_render_mode;
  }

  function function_39a68bf2(stop_update = 1, var_93eea46f = 0) {
    var_1d18f5c7 = 0;

    if(stop_update) {
      self notify(#"hash_578cb70e92c24a5a");
      var_1d18f5c7 = 1;
    }

    if(isDefined(var_54430cb6)) {
      var_a287debe scene::cancel(var_54430cb6, 0);

      if(!var_93eea46f) {
        var_54430cb6 = undefined;
        var_5d01abf7 = undefined;
        var_6ce65c01 = undefined;
        var_a287debe = undefined;
      }
    }
  }

  function set_xuid(xuid) {
    _xuid = xuid;
  }

  function function_4240a39a(var_1f64805f, angles) {
    var_ef017bf9 = var_1f64805f;

    if(isDefined(angles)) {
      var_228f64da.angles = angles;
      return;
    }

    var_228f64da.angles = _angles;
  }

  function function_4508c737() {
    if(var_fa881a || var_d47cfe9d) {
      return;
    }

    self notify("41ed1cc7d43366cc");
    self endon("41ed1cc7d43366cc");
    waitframe(1);
    var_28ced8cb = function_6fdb79b8(var_1d73bad9, var_cf55444c, _i_mode);

    if(isDefined(var_28ced8cb) && isDefined(var_228f64da)) {
      var_28ced8cb += "_lobby";
      var_37d425ec = playtagfxset(var_f141235b, var_28ced8cb, var_228f64da);
    }
  }

  function function_47cb6b19() {
    return var_228f64da getentitynumber();
  }

  function set_character_outfit(outfit_index) {
    assert(_i_mode != 4);

    if(var_cf55444c != outfit_index) {
      var_b627749c = 1;
      var_cf55444c = outfit_index;
    }
  }

  function function_4a209fe9(var_ced588d9) {
    var_d47cfe9d = var_ced588d9;
  }

  function function_4a271da1() {
    return var_ef017bf9;
  }

  function private function_4b2b3712(localclientnum, weaponmodel, camooptions, var_49daa2f6) {
    camoindex = getcamoindex(camooptions);
    var_f4eb4a50 = activecamo::function_13e12ab1(camoindex);

    if(!isDefined(var_f4eb4a50)) {
      return false;
    }

    stage = getactivecamostage(camooptions);
    var_3594168e = var_f4eb4a50.stages[stage];
    return activecamo::function_6c9e0e1a(localclientnum, weaponmodel, var_3594168e, var_49daa2f6);
  }

  function function_59d1302f() {
    for(itemtype = 0; itemtype < 8; itemtype++) {
      function_ac9cc79d(itemtype);
    }
  }

  function function_5ccc06e3() {
    return var_7245a8e1;
  }

  function private function_60b3658e(var_2ec36514, need_wait) {
    if(need_wait) {
      self endon(#"deleted", #"hash_578cb70e92c24a5a");
      self waittill(#"cancel_gesture", #"gesture_ended");
    }

    if(isDefined(var_2ec36514)) {
      var_228f64da thread animation::play(var_2ec36514, var_228f64da);
      return;
    }

    if(isDefined(var_54430cb6)) {
      if(var_8d2161e9) {
        var_a287debe thread scene::play(var_54430cb6, var_228f64da);
      }
    }
  }

  function function_617a9ce4(character_mode) {
    assert(character_mode === _i_mode);
  }

  function function_62dd99d6(model) {
    render_options = function_aa478513({
      #mode: _i_mode, #characterindex: var_1d73bad9, #outfitindex: var_cf55444c, #warpaintoutfitindex: var_cfe86a3e, #outfitoptions: var_f5c0467b
    });
    model function_1fac41e4(render_options);
  }

  function private function_66de4847() {
    if(isDefined(var_ff2bed36)) {
      var_ff2bed36 delete();
      var_ff2bed36 = undefined;
    }

    if(isDefined(var_8d79cdc7)) {
      var_8d79cdc7 delete();
      var_8d79cdc7 = undefined;
    }

    foreach(model_data in var_506d3c33) {
      character_customization::function_247f6628(model_data.model, model_data.lod, model_data.mip);
    }

    var_506d3c33 = [];
  }

  function function_690c9509() {
    return isDefined(var_81bd1932) ? var_81bd1932 : var_f141235b;
  }

  function function_69ac4009(gesture_index) {
    gesture = get_gesture(gesture_index);
  }

  function function_6b9e9618() {
    return var_fa881a;
  }

  function function_72be01b9() {
    set_character_outfit(function_9ec573f1(var_f141235b, _i_mode, var_1d73bad9));
  }

  function set_character_index(character_index) {
    assert(isDefined(character_index));

    if(var_1d73bad9 != character_index && character_index != -1000) {
      var_b627749c = 1;
      var_1d73bad9 = character_index;
    }
  }

  function function_7412658d(params) {
    if(var_640fbaae !== params.exploder_id) {
      if(isDefined(var_640fbaae)) {
        killradiantexploder(var_f141235b, var_640fbaae);
      }

      var_640fbaae = params.exploder_id;

      if(isDefined(var_640fbaae)) {
        playradiantexploder(var_f141235b, var_640fbaae);
      }
    }
  }

  function function_7792df22(locked) {
    if(var_444a0d45 != locked) {
      var_444a0d45 = locked;
      function_2a5421e3();
    }
  }

  function function_77e3be08() {
    function_72be01b9();
    function_10b0cbea();
    function_59d1302f();
  }

  function function_782bdd96() {
    return var_54430cb6;
  }

  function function_79f89fb6(var_925f39ce) {
    var_9896541c = var_925f39ce;
  }

  function update_internal(params) {
    self notify("66242bbbf0fe2524");
    self endon("66242bbbf0fe2524");
    level endon(#"disconnect");
    self endon(#"deleted", #"hash_578cb70e92c24a5a");

    if(isDefined(var_9bea772f)) {
      function_66b6e720(var_9bea772f);
      var_9bea772f = undefined;

      if(var_43b94d19) {
        var_228f64da show();

        if(isDefined(var_e09268b7) && var_b6892e9d) {
          var_e09268b7 show();
        }
      }
    }

    function_66de4847();
    function_878481();

    if(!isDefined(params)) {
      params = {};
    }

    var_1d18f5c7 = 0;

    if(!is_true(params.var_401d9a1)) {
      function_27945cb8(0);
    }

    if(is_true(params.var_90d2372c)) {
      base_model = # "hash_2b18a5af849da51b";
      attached_models = [#"outfit_head": # "tag_origin", #"outfit_headgear": # "tag_origin", #"outfit_legs": # "tag_origin", #"outfit_torso": # "tag_origin"];
    } else if(function_bf7bce05()) {
      base_model = function_d5e754c6();
      attached_models = [#"outfit_head": function_8c6b7af7(params), #"outfit_headgear": # "tag_origin", #"outfit_legs": # "tag_origin", #"outfit_torso": # "tag_origin"];
    } else {
      base_model = function_b06080fb();
      attached_models = [#"outfit_head": function_8c6b7af7(params), #"outfit_headgear": function_1978bfeb(), #"outfit_legs": function_cdc02b18(), #"outfit_torso": function_d5e754c6()];
    }

    var_9e7c4fde = array(base_model);
    var_ff2bed36 = util::spawn_model(var_f141235b, base_model, var_228f64da.origin);
    var_ff2bed36 hide();

    if(is_true(params.var_6fe1d7c5)) {
      waitframe(1);
    }

    var_8d79cdc7 = util::spawn_model(var_f141235b, base_model, var_228f64da.origin);
    var_8d79cdc7 hide();
    var_8d79cdc7 function_2649d965(1);
    var_8d79cdc7 sethighdetail(var_851003fe);

    if(is_true(params.var_6fe1d7c5)) {
      waitframe(1);
    }

    function_9b661089(params);
    _models = [];

    foreach(slot, model in attached_models) {
      if(isDefined(model) && !isDefined(array::find(var_9e7c4fde, model))) {
        array::add(var_9e7c4fde, model);
        bone = isDefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot;
        var_ff2bed36 attach(model, bone);
        var_8d79cdc7 attach(model, bone);
      }
    }

    if(isDefined(params.activeweapon)) {
      var_ff2bed36 attachweapon(params.activeweapon, isDefined(params.var_b8f20727) ? params.var_b8f20727 : 0, isDefined(params.var_452aa9c0) ? params.var_452aa9c0 : 0);
      var_8d79cdc7 attachweapon(params.activeweapon, isDefined(params.var_b8f20727) ? params.var_b8f20727 : 0, isDefined(params.var_452aa9c0) ? params.var_452aa9c0 : 0);
    }

    foreach(model in var_9e7c4fde) {
      force_stream_model(model);
    }

    if(is_true(params.var_d8cb38a9) && isDefined(params.scene)) {
      var_9bea772f = params.scene;
      var_a942d0c7 = 1;

      while(!forcestreambundle(params.scene)) {
        if(var_a942d0c7) {
          var_228f64da hide();

          if(isDefined(var_e09268b7)) {
            var_e09268b7 notify(#"hash_3397ccfc250ad36");
            var_e09268b7 hide();
          }

          var_a942d0c7 = 0;
        }

        waitframe(1);
      }

      if(var_43b94d19) {
        var_228f64da show();

        if(isDefined(var_e09268b7) && var_b6892e9d) {
          var_e09268b7 show();
        }
      }
    }

    var_56293673 = 1;

    foreach(model in var_9e7c4fde) {
      var_56293673 &= function_c358189(model);
    }

    if(is_true(params.var_90d2372c) && var_228f64da.model !== # "hash_2b18a5af849da51b" || !is_true(params.var_90d2372c) && var_228f64da.model === # "hash_2b18a5af849da51b") {
      var_b627749c = 1;
    }

    if(!is_true(params.var_90d2372c)) {
      function_62dd99d6(var_ff2bed36);
      function_62dd99d6(var_8d79cdc7);
    }

    if(is_true(params.var_c76f3e47) && !var_c31e86ed && !var_ff2bed36 function_e56f5549()) {
      if(is_true(params.var_401d9a1)) {
        if(isDefined(var_228f64da)) {
          var_228f64da hide();
        }

        if(isDefined(var_e09268b7)) {
          var_e09268b7 notify(#"hash_3397ccfc250ad36");
          var_e09268b7 hide();
        }

        function_27945cb8(1, 1);
        outfit_index = function_9ec573f1(var_f141235b, _i_mode, var_1d73bad9);
        var_d92aad5c = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 0);
        var_2f1dcdbb = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 2);
        var_cb9bcfe7 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 3);
        var_173f7170 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 4);
        var_1f170bc0 = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, 6);

        if(function_bf7bce05()) {
          var_867954ad = character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, outfit_index, 0, _i_mode);
          var_89610e9c = [#"outfit_head": character_customization::function_6bca50af(&startquantity, var_1d73bad9, outfit_index, 0, _i_mode), #"outfit_headgear": # "tag_origin", #"outfit_legs": # "tag_origin", #"outfit_torso": # "tag_origin"];
        } else {
          var_867954ad = character_customization::function_6bca50af(&function_5d23af5b, var_1d73bad9, outfit_index, var_d92aad5c, _i_mode);
          var_89610e9c = [#"outfit_head": character_customization::function_6bca50af(&startquantity, var_1d73bad9, outfit_index, var_2f1dcdbb, _i_mode), #"outfit_headgear": character_customization::function_6bca50af(&function_6b7000e, var_1d73bad9, outfit_index, var_cb9bcfe7, _i_mode), #"outfit_legs": character_customization::function_6bca50af(&function_cde23658, var_1d73bad9, outfit_index, var_173f7170, _i_mode), #"outfit_torso": character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, outfit_index, var_1f170bc0, _i_mode)];
        }

        var_cf2f5fb7 = array(var_867954ad);

        foreach(model in var_89610e9c) {
          if(!isDefined(var_cf2f5fb7)) {
            var_cf2f5fb7 = [];
          } else if(!isarray(var_cf2f5fb7)) {
            var_cf2f5fb7 = array(var_cf2f5fb7);
          }

          if(!isinarray(var_cf2f5fb7, model)) {
            var_cf2f5fb7[var_cf2f5fb7.size] = model;
          }
        }

        var_a9916921 = getdvarint(#"hash_388720e05d574ed2", 1);

        foreach(model in var_cf2f5fb7) {
          force_stream_model(model, var_a9916921, 0);
        }

        n_timeout = 0;

        do {
          waitframe(1);
          var_e2e2ee90 = 1;

          foreach(model in var_cf2f5fb7) {
            var_e2e2ee90 &= function_c358189(model, var_a9916921, 0);
          }

          n_timeout += 0.016;
        }
        while(!var_e2e2ee90 && n_timeout < level.var_d323a7f5);

        function_91cd5499(util::spawn_model(var_f141235b, var_867954ad, _origin, _angles), 0, 0);
        var_b627749c = 1;
        function_27945cb8(1, 1);

        if(!var_43b94d19) {
          var_228f64da hide();

          if(isDefined(var_e09268b7)) {
            var_e09268b7 notify(#"hash_3397ccfc250ad36");
            var_e09268b7 hide();
          }
        }

        var_cc204afb = [];

        foreach(slot, model in var_89610e9c) {
          if(isDefined(model) && !isDefined(array::find(var_cc204afb, model))) {
            array::add(var_cc204afb, model);
            bone = isDefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot;
            var_228f64da attach(model, bone);
          }
        }

        function_ef064067(params, 1);
        var_61ef988d = 1;

        foreach(model in var_cf2f5fb7) {
          function_b020b858(model, var_a9916921, 0);
        }
      }

      n_timeout = 0;

      do {
        waitframe(1);
        n_timeout += 0.016;
      }
      while(!var_ff2bed36 isstreamed(params.var_5bd51249, params.var_13fb1841) && n_timeout < level.var_d323a7f5);
    }

    var_ff704b7c = is_true(params.var_99a89f83);

    if(var_b627749c) {
      var_b627749c = 0;
      var_ff704b7c = 1;
      function_39a68bf2(0);

      if(is_true(var_61ef988d) && !isDefined(params.var_f5332569)) {
        params.var_f5332569 = function_98d70bef();
      }

      if(!isDefined(params.var_b1e821c5)) {
        params.var_b1e821c5 = spawnStruct();
      }

      params.var_b1e821c5.blend = 0;

      if(isDefined(base_model)) {
        function_91cd5499(util::spawn_model(var_f141235b, base_model, _origin, _angles));
        var_45210dc7 = [];
        var_bf273e28 = [];
        var_5633914d = [];
      }

      if(!var_43b94d19) {
        var_228f64da hide();

        if(isDefined(var_e09268b7)) {
          var_e09268b7 notify(#"hash_3397ccfc250ad36");
          var_e09268b7 hide();
        }
      } else {
        var_228f64da show();

        if(isDefined(var_e09268b7)) {
          thread function_c23b6091(params);
        }
      }
    }

    foreach(slot, model in attached_models) {
      update_model_attachment(model, slot, undefined, undefined, 1);
    }

    if(!is_true(params.var_90d2372c)) {
      function_62dd99d6(var_228f64da);
    }

    function_66de4847();
    changed = function_ef064067(params, var_ff704b7c);
    function_dd872e2b(params, changed);
    function_7412658d(params);
    var_9bea772f = undefined;

    if(is_true(params.var_401d9a1)) {
      function_27945cb8(0);
    }

    if(is_true(params.var_8d3b5f69)) {
      fbc = getuimodel(function_5f72e972(#"lobby_root"), "fullscreenBlackCount");
      setuimodelvalue(fbc, 0);
    }

    function_4508c737();
    thread function_81d84c71();
    var_1d18f5c7 = 1;
    var_2d0192e5 = function_82e05d64();

    if(isDefined(var_2d0192e5)) {
      if(isDefined(var_2d0192e5.visible_model)) {
        setuimodelvalue(var_2d0192e5.visible_model, function_ea4ac9f8() && is_visible());
      }
    }

    gestureindex = character_customization::function_6aee5a4e(self);

    if(isDefined(gestureindex) && gestureindex > 0) {
      thread play_gesture(gestureindex, 0, 1, 0);
    }
  }

  function function_7ed995de(local_client_num, character_model, alt_render_mode = 1) {
    assert(!isDefined(var_228f64da), "<dev string:x38>");
    var_f141235b = local_client_num;
    var_81bd1932 = local_client_num;
    var_bf4feef5 = alt_render_mode;
    _target_name = character_model.targetname;
    _origin = character_model.origin;
    _angles = character_model.angles;
    function_91cd5499(character_model);
  }

  function function_8144231c() {
    if(!var_c31e86ed && # "female" === getherogender(var_1d73bad9, _i_mode)) {
      return # "pb_fem_frontend_default";
    }

    return # "pb_male_frontend_default";
  }

  function function_81d84c71() {
    self notify("7ebf15d8a46f93ae");
    self endon("7ebf15d8a46f93ae");

    if(var_9896541c) {
      while(function_d9aed86()) {
        waitframe(1);
      }

      if(isDefined(var_eb95665)) {
        var_228f64da function_5790ec6e(var_eb95665);
      } else {
        var_228f64da function_a72ef0c5(var_f141235b, _i_mode);
      }

      return;
    }

    var_228f64da function_a7842493();
  }

  function function_82e05d64() {
    if(!isDefined(var_d781e2e4)) {
      var_d781e2e4 = {};
    }

    return var_d781e2e4;
  }

  function function_8567daf2() {
    return var_87449256;
  }

  function set_character_outfit_item(item_index, item_type) {
    assert(_i_mode != 4);

    if(var_f5c0467b[item_type] != item_index) {
      var_b627749c |= item_type == 0 || item_type == 2 || item_type == 3 || item_type == 4 || item_type == 6;
      var_f5c0467b[item_type] = item_index;
    }
  }

  function function_8c6b7af7(params) {
    if(var_c31e86ed) {
      return # "c_t8_mp_swatbuddy_head2";
    }

    if(!function_ef6f931f(params)) {
      return # "tag_origin";
    }

    return character_customization::function_6bca50af(&startquantity, var_1d73bad9, var_cf55444c, var_f5c0467b[2], _i_mode);
  }

  function get_character_index() {
    return var_1d73bad9;
  }

  function function_9146bf81(itemindex, itemtype) {
    outfit_index = itemtype == 7 ? var_cfe86a3e : var_cf55444c;

    if(!isDefined(itemindex)) {
      itemindex = function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, itemtype);
    }

    set_character_outfit_item(itemindex, itemtype);
  }

  function private function_91cd5499(character_model, var_87606b20, var_584905de) {
    if(isDefined(var_228f64da)) {
      _origin = var_228f64da.origin;
      _angles = var_228f64da.angles;
      function_39a68bf2(0);
      var_228f64da delete();
    }

    var_228f64da = character_model;
    var_228f64da.targetname = _target_name;
    var_228f64da.origin = _origin;
    var_228f64da.angles = _angles;
    var_228f64da sethighdetail(isDefined(var_87606b20) ? var_87606b20 : var_851003fe, isDefined(var_584905de) ? var_584905de : var_bf4feef5);

    if(var_228f64da hasdobj(var_f141235b) && !var_228f64da hasanimtree()) {
      var_228f64da useanimtree("all_player");
    }

    var_228f64da.var_90ff9782 = self;
    var_228f64da.var_463f8196 = 1;
    function_2a5421e3();
    function_c39fbf91();

    if(getdvarint(#"hash_59cf96a0da4d7689", 0)) {
      function_bba23c40(#"cg_drawbonesentnum", var_228f64da getentitynumber());
    }
  }

  function function_95779b72() {
    for(itemtype = 0; itemtype < 8; itemtype++) {
      set_character_outfit_item(0, itemtype);
    }
  }

  function function_98d70bef() {
    if(isDefined(var_228f64da)) {
      animation = var_228f64da getcurrentanimscriptedname();

      if(isDefined(animation)) {
        return var_228f64da getanimtime(animation);
      }
    }
  }

  function function_9afbd994() {
    return var_5d01abf7;
  }

  function function_9b661089(params) {
    if(is_true(params.var_66125429) && isDefined(_xuid)) {
      var_7245a8e1 = function_aa09bdbb(_xuid);

      if(isDefined(var_7245a8e1) && var_7245a8e1 != # "") {
        var_521d2f55 = function_61067007(var_7245a8e1);
        var_7668a4b7 = var_521d2f55.var_fdd95115;
        var_d53d9189 = var_521d2f55.var_8c74e89e;
        var_d1e7f9fe = var_521d2f55.var_ec729ae9;
      }

      var_b8d88aa7 = getdvarstring(#"hash_54784bf3c8d31aeb", "<dev string:x6f>");

      if(var_b8d88aa7 != "<dev string:x6f>") {
        var_7668a4b7 = var_b8d88aa7;
      }

      var_ba3f954 = getdvarstring(#"hash_1a45902f305b10a4", "<dev string:x6f>");

      if(var_ba3f954 != "<dev string:x6f>") {
        var_d53d9189 = var_ba3f954;
      }

      if(isDefined(var_e09268b7)) {
        var_e09268b7 delete();
      }

      if(isDefined(var_7668a4b7)) {
        var_e09268b7 = util::spawn_anim_model(var_f141235b, var_7668a4b7, _origin, _angles);
        var_e09268b7.var_463f8196 = 1;
        var_e09268b7 hide();
        var_e09268b7 function_2649d965(1);
        var_e09268b7 sethighdetail(var_851003fe);
        var_e09268b7.animname = isDefined(var_d53d9189) ? var_d53d9189 : # "companion";
        var_b6892e9d = 1;
        force_stream_model(var_7668a4b7);
        thread function_c23b6091(params, var_d1e7f9fe);
      } else {
        var_b6892e9d = 0;
      }

      return;
    }

    if(isDefined(var_e09268b7)) {
      var_e09268b7 delete();
    }

    var_b6892e9d = 0;
  }

  function show_model() {
    if(isDefined(var_228f64da)) {
      var_228f64da show();
    }

    if(isDefined(var_e09268b7) && var_b6892e9d) {
      var_e09268b7 show();
    }

    var_43b94d19 = 1;
    function_c39fbf91();
  }

  function get_angles() {
    return _angles;
  }

  function function_ac9cc79d(itemtype) {
    outfit_index = itemtype == 7 ? var_cfe86a3e : var_cf55444c;
    set_character_outfit_item(function_bd9a67ae(var_f141235b, _i_mode, var_1d73bad9, outfit_index, itemtype), itemtype);
  }

  function delete_models() {
    self notify(#"deleted");

    foreach(ent in var_5633914d) {
      ent unlink();
      ent delete();
    }

    level.custom_characters[var_f141235b][var_228f64da.targetname] = undefined;
    var_5633914d = [];
    var_228f64da delete();
    var_228f64da = undefined;
    function_66de4847();
  }

  function private function_b020b858(model_name, lod = -1, mip = -1) {
    index = array::find(var_506d3c33, {
      #model: model_name, #lod: lod, #mip: mip
    }, &function_1a57b132);

    if(isDefined(index)) {
      array::pop(var_506d3c33, index, 0);
      character_customization::function_247f6628(model_name, lod, mip);
    }
  }

  function function_b06080fb() {
    if(var_c31e86ed) {
      return # "tag_origin";
    }

    return character_customization::function_6bca50af(&function_5d23af5b, var_1d73bad9, var_cf55444c, var_f5c0467b[0], _i_mode);
  }

  function play_gesture(gesture_index, wait_until_model_steam_ends, replay_if_already_playing = 1, ignore_if_already_playing = 0) {
    self endon(#"deleted");
    self endon(#"cancel_gesture");

    if(wait_until_model_steam_ends && isDefined(var_1d18f5c7)) {
      while(!function_ea4ac9f8()) {
        wait 0.25;
      }
    }

    var_2ec36514 = var_cbcee022;
    function_39a68bf2(1, 1);
    gesture = get_gesture(gesture_index);

    if(isDefined(gesture) && isDefined(gesture.animation)) {
      self endon(#"hash_578cb70e92c24a5a", #"cancel_gesture");

      while(!isDefined(var_cbcee022) && !isDefined(var_54430cb6)) {
        wait 0.1;
      }

      var_a7e34ee1 = var_228f64da getcurrentanimscriptedname();
      var_99789677 = var_a7e34ee1 === gesture.animation || var_a7e34ee1 === gesture.intro || var_a7e34ee1 === gesture.outro;

      if(!ignore_if_already_playing || !var_99789677) {
        if(replay_if_already_playing || !var_99789677) {
          self thread function_60b3658e(var_2ec36514, 1);
          character_customization::function_bee62aa1(self);

          if(isDefined(gesture.intro)) {
            var_228f64da animation::play(gesture.intro, var_228f64da);
          }

          var_228f64da animation::play(gesture.animation, var_228f64da);

          if(isDefined(gesture.outro)) {
            var_228f64da animation::play(gesture.outro, var_228f64da);
          }

          self notify(#"gesture_ended");
          return;
        }

        self thread function_60b3658e(var_2ec36514, 0);
      }
    }
  }

  function is_visible() {
    return var_43b94d19;
  }

  function function_b94f710e() {
    if(isDefined(var_cbcee022)) {
      function_39a68bf2();
      var_228f64da thread character_customization::play_intro_and_animation(_origin, _angles, undefined, var_cbcee022, 0);
    } else if(isDefined(var_54430cb6)) {
      function_39a68bf2();

      if(var_8d2161e9) {
        var_a287debe thread scene::play(var_54430cb6, var_228f64da);
      } else {
        var_a287debe thread scene::play(var_54430cb6);
      }
    }

    foreach(slot, ent in var_5633914d) {
      ent thread character_customization::play_intro_and_animation(_origin, _angles, undefined, var_bf273e28[slot], 1);
    }
  }

  function private force_stream_model(model_name, lod = -1, mip = -1) {
    array::add(var_506d3c33, {
      #model: model_name, #lod: lod, #mip: mip
    });
    character_customization::function_221a94ac(model_name, lod, mip);
  }

  function hide_model() {
    var_228f64da hide();

    if(isDefined(var_e09268b7)) {
      var_e09268b7 notify(#"hash_3397ccfc250ad36");
      var_e09268b7 hide();
    }

    self notify(#"cancel_gesture");
    var_43b94d19 = 0;
    function_c39fbf91();
  }

  function function_bf7bce05() {
    if(var_c31e86ed) {
      return 1;
    }

    return function_4611d0e6(_i_mode, var_1d73bad9);
  }

  function function_c0ccd9ea(default_exploder) {
    var_266b2ff0 = default_exploder;
  }

  function set_character_mode(character_mode) {
    assert(isDefined(character_mode));

    if(_i_mode != character_mode) {
      var_b627749c = 1;
      _i_mode = character_mode;
    }
  }

  function function_c23b6091(params, var_d1e7f9fe) {
    self notify("55d3cc387c4236bd");
    self endon("55d3cc387c4236bd");
    var_e09268b7 endon(#"death", #"hash_3397ccfc250ad36");
    var_e09268b7 hide();

    if(is_true(params.var_c76f3e47)) {
      n_timeout = 0;

      do {
        waitframe(1);
        n_timeout += 0.016;
      }
      while((!var_e09268b7 function_e56f5549() || !function_ea4ac9f8()) && n_timeout < level.var_d323a7f5);
    }

    if(var_b6892e9d) {
      var_e09268b7 hide();

      while(!function_ea4ac9f8()) {
        waitframe(1);
      }

      if(var_43b94d19) {
        var_e09268b7 show();

        if(isDefined(var_d1e7f9fe)) {
          var_e09268b7 playrenderoverridebundle(var_d1e7f9fe);
        }
      }

      return;
    }

    var_e09268b7 hide();

    if(isDefined(var_d1e7f9fe)) {
      var_e09268b7 stoprenderoverridebundle(var_d1e7f9fe);
    }
  }

  function private function_c39fbf91() {
    foreach(callback in var_180f1c7d) {
      [[callback]](var_f141235b, self);
    }
  }

  function function_c4baf89b(showcase_weapon) {
    var_87449256 = showcase_weapon;
    var_b627749c = 1;
  }

  function function_cdc02b18() {
    if(var_c31e86ed) {
      return # "tag_origin";
    }

    return character_customization::function_6bca50af(&function_cde23658, var_1d73bad9, var_cf55444c, var_f5c0467b[4], _i_mode);
  }

  function set_show_helmets(show_helmets) {
    if(var_609efd3e != show_helmets) {
      var_609efd3e = show_helmets;
      function_c1aab607();
    }
  }

  function function_d5e754c6() {
    if(var_c31e86ed) {
      return # "c_t8_mp_swatbuddy_body2";
    }

    return character_customization::function_6bca50af(&function_92ea4100, var_1d73bad9, var_cf55444c, var_f5c0467b[6], _i_mode);
  }

  function function_d72d0c2d(var_ced588d9) {
    var_fa881a = var_ced588d9;
  }

  function function_dd872e2b(params, force_updates) {
    if(isDefined(params.weapon_right) || isDefined(params.weapon_left)) {
      update_model_attachment(params.weapon_right, "tag_weapon_right", params.weapon_right_anim, params.weapon_right_anim_intro, force_updates);
      update_model_attachment(params.weapon_left, "tag_weapon_left", params.weapon_left_anim, params.weapon_left_anim_intro, force_updates);
      return;
    }

    if(isDefined(params.activeweapon)) {
      var_228f64da attachweapon(params.activeweapon, isDefined(params.var_b8f20727) ? params.var_b8f20727 : 0, isDefined(params.var_452aa9c0) ? params.var_452aa9c0 : 0, 1);

      if(isDefined(level.var_a9b637b1)) {
        var_228f64da thread[[level.var_a9b637b1]](var_f141235b, params.activeweapon, isDefined(params.var_452aa9c0) ? params.var_452aa9c0 : 0, getdvarint(#"hash_41ef264ae8370dc7", 6));
      }

      var_228f64da useweaponhidetags(params.activeweapon);
    }
  }

  function function_e08bf4f2(var_db61785f) {
    var_81bd1932 = var_db61785f;
  }

  function update_model_attachment(attached_model, slot, model_anim, model_intro_anim, force_update) {
    assert(isDefined(level.model_type_bones));

    if(force_update || attached_model !== var_45210dc7[slot] || model_anim !== var_bf273e28[slot]) {
      bone = isDefined(level.model_type_bones[slot]) ? level.model_type_bones[slot] : slot;
      assert(isDefined(bone));

      if(isDefined(var_45210dc7[slot])) {
        if(isDefined(var_5633914d[slot])) {
          var_5633914d[slot] unlink();
          var_5633914d[slot] delete();
          var_5633914d[slot] = undefined;
        } else if(var_228f64da isattached(var_45210dc7[slot], bone)) {
          var_228f64da detach(var_45210dc7[slot], bone);
        }

        var_45210dc7[slot] = undefined;
      }

      var_45210dc7[slot] = attached_model;

      if(isDefined(var_45210dc7[slot])) {
        if(isDefined(model_anim)) {
          ent = spawn(var_f141235b, var_228f64da.origin, "script_model");
          ent sethighdetail(var_851003fe, var_bf4feef5);
          var_5633914d[slot] = ent;
          ent setModel(var_45210dc7[slot]);

          if(!ent hasanimtree()) {
            ent useanimtree("generic");
          }

          ent.origin = _origin;
          ent.angles = _angles;
          ent thread character_customization::play_intro_and_animation(_origin, _angles, model_intro_anim, model_anim, 1);
        } else if(!var_228f64da isattached(var_45210dc7[slot], bone)) {
          var_228f64da attach(var_45210dc7[slot], bone);
        }

        var_bf273e28[slot] = model_anim;
      }
    }

    if(isDefined(var_5633914d[slot])) {
      function_62dd99d6(var_5633914d[slot]);
    }
  }

  function function_e599283f() {
    return {
      #xuid: _xuid, #charactermode: _i_mode, #charactertype: var_1d73bad9, #outfit: var_cf55444c, #warpaintoutfit: var_cfe86a3e, #outfititems: var_f5c0467b
    };
  }

  function get_origin() {
    return _origin;
  }

  function function_e8b0acef() {
    return getcharacterfields(var_1d73bad9, _i_mode);
  }

  function function_ea4ac9f8() {
    return var_1d18f5c7;
  }

  function function_ef064067(params, force_update) {
    changed = 0;

    if(!isDefined(params)) {
      params = {};
    }

    if(!isDefined(params.exploder_id)) {
      params.exploder_id = var_266b2ff0;
    }

    align_changed = 0;

    if(isDefined(var_9a4a8ea)) {
      if(!isDefined(params.align_struct)) {
        params.align_struct = struct::get(var_9a4a8ea);
      }
    }

    if(isDefined(params.align_struct) && (params.align_struct.origin !== _origin || params.align_struct.angles !== _angles)) {
      _origin = params.align_struct.origin;
      _angles = params.align_struct.angles;

      if(!isDefined(params.anim_name)) {
        params.anim_name = var_cbcee022;
      }

      align_changed = 1;
    }

    if(isDefined(params.anim_name) && (params.anim_name !== var_cbcee022 || align_changed || force_update)) {
      changed = 1;
      function_39a68bf2(0);
      var_cbcee022 = params.anim_name;
      var_54430cb6 = undefined;
      var_5d01abf7 = undefined;
      var_6ce65c01 = undefined;
      var_a287debe = undefined;
      var_228f64da thread character_customization::play_intro_and_animation(_origin, _angles, params.anim_intro_name, var_cbcee022, 0);
    } else if(isDefined(params.scene) && (params.scene !== var_54430cb6 || params.scene_target !== var_a287debe || is_true(params.var_a34c858c) != var_8d2161e9 || force_update)) {
      changed = 1;
      function_39a68bf2(0);
      var_54430cb6 = params.scene;
      var_5d01abf7 = params.var_74741b75;
      var_6ce65c01 = params.var_a68ab9c2;
      var_a287debe = isDefined(params.scene_target) ? params.scene_target : level;
      var_8d2161e9 = is_true(params.var_a34c858c);
      var_cbcee022 = undefined;
      models = [];

      if(var_8d2161e9) {
        if(!isDefined(models)) {
          models = [];
        } else if(!isarray(models)) {
          models = array(models);
        }

        models[models.size] = var_228f64da;
      }

      if(var_b6892e9d && isDefined(var_e09268b7)) {
        if(!isDefined(models)) {
          models = [];
        } else if(!isarray(models)) {
          models = array(models);
        }

        models[models.size] = var_e09268b7;
      }

      thread character_customization::function_f7a5fba4(var_a287debe, var_54430cb6, models, var_5d01abf7, var_6ce65c01, params.var_f5332569, params.var_b1e821c5, params.var_bfbc1f4f);
    }

    return changed;
  }

  function function_ef6f931f(params) {
    return true;
  }

  function function_f941c5de(params) {
    return true;
  }

  function get_gesture(gesture_index) {
    if(gesture_index == -1) {
      if(#"female" === getherogender(var_1d73bad9, _i_mode)) {
        return {
          #animation: # "pb_rifle_fem_stand_spray_fb"};
      } else {
        return {
          #animation: # "pb_rifle_male_stand_spray_fb"};
      }
    }

    return function_2a6a2af(var_1d73bad9, _i_mode, gesture_index);
  }
}

function private autoexec __init__system__() {
  system::register(#"character_customization", &preinit, undefined, undefined, undefined);
}

function function_6bca50af(fn, character_index, outfit_index, var_e1daa8d9, mode) {
  model = [[fn]](character_index, outfit_index, var_e1daa8d9, mode);

  if(!isDefined(model)) {
    model = [[fn]](character_index, outfit_index, 0, mode);

    if(!isDefined(model)) {
      model = [[fn]](character_index, 0, 0, mode);
    }
  }

  return isDefined(model) ? model : # "tag_origin";
}

function function_6aee5a4e(character) {
  if(isDefined(level.var_6963abdb)) {
    var_2d0192e5 = [[character]] - > function_82e05d64();

    if(isDefined(var_2d0192e5) && isDefined(var_2d0192e5.xuid)) {
      xuid = xuidtostring(var_2d0192e5.xuid);
      return level.var_6963abdb[xuid];
    }

    if(isDefined(character._xuid)) {
      return level.var_6963abdb[character._xuid];
    }
  }

  return 0;
}

function function_bee62aa1(character) {
  if(isDefined(level.var_6963abdb)) {
    var_2d0192e5 = [[character]] - > function_82e05d64();

    if(isDefined(var_2d0192e5) && isDefined(var_2d0192e5.xuid)) {
      xuid = xuidtostring(var_2d0192e5.xuid);
      level.var_6963abdb[xuid] = 0;
    }

    if(isDefined(character._xuid)) {
      level.var_6963abdb[character._xuid] = 0;
    }
  }
}

function private preinit() {
  level.model_type_bones = [#"outfit_head": "", #"outfit_headgear": "", #"outfit_legs": "", #"outfit_torso": ""];

  if(!isDefined(level.custom_characters)) {
    level.custom_characters = [];
  }

  level.charactercustomizationsetup = &localclientconnect;
  level.var_6e23b0fc = [];
  level.var_d323a7f5 = getdvarfloat(#"hash_5fba2278b1340b1c", 8);
}

function localclientconnect(localclientnum) {}

function private function_cb64c6d0(model_name, lod, mip) {
  if(!isDefined(level.var_6e23b0fc[model_name])) {
    level.var_6e23b0fc[model_name] = array();
  }

  if(!isDefined(level.var_6e23b0fc[model_name][lod])) {
    level.var_6e23b0fc[model_name][lod] = array();
  }

  if(!isDefined(level.var_6e23b0fc[model_name][lod][mip])) {
    level.var_6e23b0fc[model_name][lod][mip] = 0;
  }
}

function function_221a94ac(model_name, lod, mip) {
  if(!isDefined(model_name)) {
    return;
  }

  function_cb64c6d0(model_name, lod, mip);
  level.var_6e23b0fc[model_name][lod][mip]++;

  if(level.var_6e23b0fc[model_name][lod][mip] == 1) {
    forcestreamxmodel(model_name, lod, mip);
  }
}

function private function_c358189(model_name, lod, mip) {
  if(!isDefined(model_name)) {
    return 1;
  }

  function_cb64c6d0(model_name, lod, mip);

  if(level.var_6e23b0fc[model_name][lod][mip] == 0) {
    function_221a94ac(model_name);
  }

  return forcestreamxmodel(model_name, lod, mip);
}

function function_247f6628(model_name, lod, mip) {
  if(!isDefined(model_name)) {
    return;
  }

  function_cb64c6d0(model_name, lod, mip);
  level.var_6e23b0fc[model_name][lod][mip]--;

  if(level.var_6e23b0fc[model_name][lod][mip] == 0) {
    stopforcestreamingxmodel(model_name);
    array::pop(level.var_6e23b0fc[model_name][lod], mip);

    if(level.var_6e23b0fc[model_name][lod].size == 0) {
      array::pop(level.var_6e23b0fc[model_name], lod);

      if(level.var_6e23b0fc[model_name].size == 0) {
        array::pop(level.var_6e23b0fc, model_name);
      }
    }
  }
}

function function_dd295310(charactermodel, localclientnum, alt_render_mode = 1) {
  if(!isDefined(charactermodel)) {
    return undefined;
  }

  if(!isDefined(level.custom_characters[localclientnum])) {
    level.custom_characters[localclientnum] = [];
  }

  if(isDefined(level.custom_characters[localclientnum][charactermodel.targetname])) {
    return level.custom_characters[localclientnum][charactermodel.targetname];
  }

  var_c372a4ea = new class_7da27482();
  [[var_c372a4ea]] - > function_7ed995de(localclientnum, charactermodel, alt_render_mode);
  level.custom_characters[localclientnum][charactermodel.targetname] = var_c372a4ea;
  return var_c372a4ea;
}

function function_aa5382ed(customization1, customization2, check_xuid = 1) {
  if(isDefined(customization1) != isDefined(customization2)) {
    return true;
  } else if(!isDefined(customization1)) {
    return false;
  }

  if(check_xuid && customization1.xuid !== customization2.xuid) {
    return true;
  }

  if(customization1.charactertype != customization2.charactertype) {
    return true;
  }

  if(customization1.outfit != customization2.outfit) {
    return true;
  }

  if(customization1.var_cfe86a3e != customization2.var_cfe86a3e) {
    return true;
  }

  for(i = 0; i < customization1.outfititems.size; i++) {
    if(customization1.outfititems[i] != customization2.outfititems[i]) {
      return true;
    }
  }

  return false;
}

function function_7474681d(local_client_num, session_mode, character_index) {
  outfit_index = function_9ec573f1(local_client_num, session_mode, character_index);
  var_17b172ca = function_76fbb09e(local_client_num, session_mode, character_index);
  outfit_items = [];

  for(itemtype = 0; itemtype < 8; itemtype++) {
    var_9b90e15d = itemtype == 7 ? var_17b172ca : outfit_index;
    outfit_items[itemtype] = function_bd9a67ae(local_client_num, session_mode, character_index, var_9b90e15d, itemtype);
  }

  return {
    #charactermode: session_mode, #charactertype: character_index, #outfit: outfit_index, #warpaintoutfit: var_17b172ca, #outfititems: outfit_items
  };
}

function function_3f5625f1(mode, character_index = 1) {
  outfit_items = [];

  for(itemtype = 0; itemtype < 8; itemtype++) {
    outfit_items[itemtype] = 0;
  }

  return {
    #charactermode: mode, #charactertype: character_index, #outfit: 0, #warpaintoutfit: 0, #outfititems: outfit_items
  };
}

function play_intro_and_animation(origin, angles, intro_anim_name, anim_name, b_keep_link) {
  self notify("71cd95407c8ce9da");
  self endon("71cd95407c8ce9da");

  if(isDefined(intro_anim_name)) {
    self animation::play(intro_anim_name, origin, angles, 1, 0, 0, 0, b_keep_link);
  }

  if(isDefined(self)) {
    self animation::play(anim_name, origin, angles, 1, 0, 0, 0, b_keep_link);
  }
}

function function_f7a5fba4(align_target, str_scene, model, var_f647c5b2, var_559c5c3e, var_b8f75d74, var_b1e821c5, var_bfbc1f4f = 0) {
  self notify("5cc62185f22ee6b");
  self endon("5cc62185f22ee6b");

  if(isDefined(var_b8f75d74) && var_b8f75d74 > 0 && var_b8f75d74 < 1) {
    if(isDefined(var_f647c5b2)) {
      align_target scene::play_from_time(str_scene, var_f647c5b2, model, var_b8f75d74, 1, 1, var_b1e821c5);

      if(isDefined(var_559c5c3e)) {
        str_scene = function_9faa5b77(str_scene);
        var_559c5c3e = function_7d2b4e1f(str_scene, var_559c5c3e);
        align_target = function_bdd0baed(var_bfbc1f4f, align_target);

        if(isDefined(var_b1e821c5.var_9e6d8a3d)) {
          var_cf0b13c3 = {
            #blend: var_b1e821c5.var_9e6d8a3d, #var_dcfaf6c7: var_b1e821c5.var_dcfaf6c7
          };
        }

        align_target thread scene::play(str_scene, var_559c5c3e, model, undefined, undefined, undefined, isDefined(var_cf0b13c3) ? var_cf0b13c3 : var_b1e821c5);
      }
    } else {
      str_scene = function_9faa5b77(str_scene);
      var_559c5c3e = function_7d2b4e1f(str_scene, var_559c5c3e);
      align_target = function_bdd0baed(var_bfbc1f4f, align_target);
      align_target thread scene::play_from_time(str_scene, var_559c5c3e, model, var_b8f75d74, 1, 1, var_b1e821c5);
    }

    return;
  }

  if(isDefined(var_f647c5b2) || isDefined(var_559c5c3e)) {
    if(isDefined(var_f647c5b2)) {
      align_target scene::play(str_scene, var_f647c5b2, model, undefined, undefined, undefined, var_b1e821c5);
    }

    if(isDefined(var_559c5c3e)) {
      str_scene = function_9faa5b77(str_scene);
      var_559c5c3e = function_7d2b4e1f(str_scene, var_559c5c3e);
      align_target = function_bdd0baed(var_bfbc1f4f, align_target);

      if(isDefined(var_b1e821c5.var_9e6d8a3d)) {
        var_cf0b13c3 = {
          #blend: var_b1e821c5.var_9e6d8a3d, #var_dcfaf6c7: var_b1e821c5.var_dcfaf6c7
        };
      }

      align_target thread scene::play(str_scene, var_559c5c3e, model, undefined, undefined, undefined, isDefined(var_cf0b13c3) ? var_cf0b13c3 : var_b1e821c5);
    }

    return;
  }

  align_target thread scene::play(str_scene, model, undefined, undefined, undefined, undefined, var_b1e821c5);
}

function function_9faa5b77(str_scene) {
  if(isDefined(self.var_72e4ebb3)) {
    str_scene = self.var_72e4ebb3;
    self.var_72e4ebb3 = undefined;
  }

  return str_scene;
}

function function_7d2b4e1f(str_scene, var_559c5c3e) {
  if(isDefined(self.var_31ccd6da) && scene::function_9730988a(str_scene, self.var_31ccd6da)) {
    var_559c5c3e = self.var_31ccd6da;
    self.var_31ccd6da = undefined;
  }

  return var_559c5c3e;
}

function function_bdd0baed(var_bfbc1f4f = 0, align_target) {
  if(var_bfbc1f4f && [[self]] - > function_ea4ac9f8()) {
    model = [[self]] - > function_217b10ed();
    align_target = {
      #origin: model.origin, #angles: model.angles
    };
  }

  return align_target;
}

function update_locked_shader(localclientnum, params) {
  if(isDefined(params.isitemunlocked) && params.isitemunlocked != 1) {
    enablefrontendlockedweaponoverlay(localclientnum, 1);
    return;
  }

  enablefrontendlockedweaponoverlay(localclientnum, 0);
}

function function_bcc8bdf4(localclientnum, var_d0b01271, waitresult, params) {
  params.anim_name = [[waitresult]] - > function_8144231c();
}

function updateeventthread(localclientnum, var_d0b01271, notifyname, var_1d7f1597 = &function_bcc8bdf4) {
  while(true) {
    waitresult = level waittill(notifyname + localclientnum);

    switch (waitresult.event_name) {
      case # "update_lcn":
        [[var_d0b01271]] - > function_e08bf4f2(waitresult.local_client_num);
        break;
      case # "update_locked":
        [[var_d0b01271]] - > function_7792df22(waitresult.locked);
        break;
      case # "refresh":
        [[var_d0b01271]] - > function_e08bf4f2(waitresult.local_client_num);
        [[var_d0b01271]] - > set_character_mode(waitresult.mode);
        [[var_d0b01271]] - > function_225b6e07();
        [[var_d0b01271]] - > function_77e3be08();
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "refresh_anim":
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
        params.var_99a89f83 = 1;

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "changehero":
        [[var_d0b01271]] - > set_character_mode(waitresult.mode);
        [[var_d0b01271]] - > set_character_index(waitresult.character_index);
        [[var_d0b01271]] - > function_77e3be08();
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "resetcharacter":
        [[var_d0b01271]] - > function_77e3be08();
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
        [[var_d0b01271]] - > update(params);
        break;
      case # "changeoutfit":
        [[var_d0b01271]] - > set_character_outfit(waitresult.outfit_index);
        [[var_d0b01271]] - > function_10b0cbea();
        [[var_d0b01271]] - > function_59d1302f();
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "changewarpaintoutfit":
        [[var_d0b01271]] - > function_72be01b9();
        [[var_d0b01271]] - > function_158505aa(waitresult.outfit_index);
        [[var_d0b01271]] - > function_59d1302f();
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "changeoutfititem":
        if(isDefined(waitresult.outfit_index)) {
          if(waitresult.item_type == 7) {
            [[var_d0b01271]] - > function_158505aa(waitresult.outfit_index);
          } else {
            [[var_d0b01271]] - > set_character_outfit(waitresult.outfit_index);
          }
        }

        [[var_d0b01271]] - > set_character_outfit_item(waitresult.item_index, waitresult.item_type);
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "hash_220546ce38834f4c":
        [[var_d0b01271]] - > function_ac9cc79d(waitresult.item_type);
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "updateface":
        [[var_d0b01271]] - > function_617a9ce4(waitresult.mode);
        thread[[var_d0b01271]] - > function_81d84c71();
        break;
      case # "previewshop":
      case # "previewshopface":
        [[var_d0b01271]] - > set_character_mode(waitresult.mode);
        [[var_d0b01271]] - > set_character_index(waitresult.character_index);
        [[var_d0b01271]] - > set_character_outfit(waitresult.outfit_index);
        [[var_d0b01271]] - > function_158505aa(waitresult.outfit_index);
        outfititems = strtok(waitresult.outfititems, ";");

        foreach(type, item in outfititems) {
          [[var_d0b01271]] - > function_9146bf81(int(item), type);
        }

        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(waitresult.event_name == "previewShopFace") {
          params.align_struct = struct::get(#"tag_align_quartermaster_character_head");
        }

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "loadpreset":
        if(isDefined(waitresult.mode)) {
          [[var_d0b01271]] - > set_character_mode(waitresult.mode);
        }

        if(isDefined(waitresult.character_index)) {
          [[var_d0b01271]] - > set_character_index(waitresult.character_index);
        }

        if(isDefined(waitresult.outfit_index)) {
          [[var_d0b01271]] - > set_character_outfit(waitresult.outfit_index);
        }

        outfititems = strtok(waitresult.presets, ";");

        foreach(type, item in outfititems) {
          if(type != 7 && type != 1) {
            [[var_d0b01271]] - > function_9146bf81(int(item), type);
          }
        }

        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "previewshopgesture":
        [[var_d0b01271]] - > set_character_mode(waitresult.mode);
        [[var_d0b01271]] - > set_character_index(waitresult.character_index);
        [[var_d0b01271]] - > function_22039feb();
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);

        if(is_true(params.var_c76f3e47)) {
          [[var_d0b01271]] - > function_27945cb8(1);
        }

        [[var_d0b01271]] - > update(params);
        break;
      case # "previewgesture":
        thread[[var_d0b01271]] - > play_gesture(waitresult.gesture_index, waitresult.wait_until_model_steam_ends, waitresult.replay_if_already_playing, waitresult.ignore_if_already_playing);
        break;
      case # "stopgesture":
        var_d0b01271 notify(#"cancel_gesture");
        break;
      case # "hide":
        [[var_d0b01271]] - > hide_model();
        break;
      case # "show":
        [[var_d0b01271]] - > show_model();
        break;
      case # "loadrandomcharacter":
        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
        [[var_d0b01271]] - > update(params);
        break;
      case # "hash_284a9fed1b3cdedb":
        if(is_true(waitresult.var_71922dc8)) {
          level.var_71922dc8 = 1;
          weapon_options = strtok(waitresult.weapon_options, ",");
          attachment_array = strtok(waitresult.var_9c3e9d34, "+");
          var_7d85cc7b = strtok(waitresult.var_8cba1516, "+");
          var_52b68ea = int(isDefined(var_7d85cc7b[0]) ? var_7d85cc7b[0] : -1);
          var_2aebb46a = int(isDefined(var_7d85cc7b[1]) ? var_7d85cc7b[1] : -1);
          var_e19ea1d1 = int(isDefined(var_7d85cc7b[2]) ? var_7d85cc7b[2] : -1);
          var_f773cd7b = int(isDefined(var_7d85cc7b[3]) ? var_7d85cc7b[3] : -1);
          var_5deb1a68 = int(isDefined(var_7d85cc7b[4]) ? var_7d85cc7b[4] : -1);
          var_619921c4 = int(isDefined(var_7d85cc7b[5]) ? var_7d85cc7b[5] : -1);
          var_3a485323 = int(isDefined(var_7d85cc7b[6]) ? var_7d85cc7b[6] : -1);
          var_501b7ec9 = int(isDefined(var_7d85cc7b[7]) ? var_7d85cc7b[7] : -1);
          level.var_1b17418f = getweapon(waitresult.weapon_ref, attachment_array);
          level.var_6cbc1adc = function_6eff28b5(localclientnum, int(weapon_options[0]), int(weapon_options[1]), int(weapon_options[2]));
          level.var_52dc8db9 = function_e601ff48(level.var_1b17418f, waitresult.var_21a477b9, var_52b68ea, var_2aebb46a, var_e19ea1d1, var_f773cd7b, var_5deb1a68, var_619921c4, var_3a485323, var_501b7ec9);
        } else {
          level.var_71922dc8 = 0;
          level.var_1b17418f = undefined;
          level.var_6cbc1adc = undefined;
          level.var_52dc8db9 = undefined;
        }

        params = {};
        [[var_1d7f1597]](localclientnum, var_d0b01271, waitresult, params);
        [[var_d0b01271]] - > update(params);
        break;
    }
  }
}

function rotation_thread_spawner(localclientnum, var_d0b01271, endonevent, var_cd34be2e) {
  if(!isDefined(endonevent)) {
    return;
  }

  baseangles = [[var_d0b01271]] - > function_217b10ed().angles;
  level update_model_rotation_for_right_stick(localclientnum, var_d0b01271, endonevent, var_cd34be2e);
  var_d0b01271.var_c492e538 = undefined;

  if(![[var_d0b01271]] - > function_4a271da1()) {
    [[var_d0b01271]] - > function_217b10ed().angles = baseangles;
  }
}

function private function_3d131a(localclientnum) {
  forcenotifyuimodel(getuimodel(function_1df4c3b0(localclientnum, #"hash_48b37823078b5999"), #"hash_6e41eda2b1b41bd"));
}

function private update_model_rotation_for_right_stick(localclientnum, var_d0b01271, endonevent, var_cd34be2e) {
  level endon(endonevent);

  while(true) {
    data_lcn = [[var_d0b01271]] - > function_690c9509();

    if(localclientnum == data_lcn && localclientactive(data_lcn) && ![[var_d0b01271]] - > function_4a271da1()) {
      model = [[var_d0b01271]] - > function_217b10ed();

      if(isDefined(model)) {
        pos = getcontrollerposition(data_lcn);
        change = pos[#"rightstick"][0];

        if(!gamepadusedlast(localclientnum)) {
          pos = getxcammousecontrol(data_lcn);
          change -= pos[#"yaw"];
        }

        s_align = {
          #origin: model.origin, #angles: model.angles
        };

        if(isDefined(var_cd34be2e.str_scene)) {
          if(isDefined(var_cd34be2e.var_c76d5a0b) && isDefined(var_cd34be2e.var_e982dc6b) && change < -0.5) {
            function_3d131a(localclientnum);
            var_d0b01271.var_c492e538 = var_cd34be2e.var_c76d5a0b;
            var_d0b01271.var_ae32b908 = model.origin;
            var_d0b01271.var_aba63ea = model.angles;

            if(isDefined(level.var_6365df1f)) {
              params = [[level.var_6365df1f]](localclientnum, var_d0b01271);
              params = function_923a14da(params, var_d0b01271);
              [[var_d0b01271]] - > update(params);
            } else {
              var_d0b01271 thread function_f7a5fba4(s_align, var_cd34be2e.str_scene, model, var_cd34be2e.var_c76d5a0b, var_cd34be2e.var_e982dc6b);
            }

            var_41173053 = scene::function_8582657c(var_cd34be2e.str_scene, var_cd34be2e.var_c76d5a0b);
            wait var_41173053;
            var_d0b01271.var_c492e538 = undefined;
            var_d0b01271.var_ae32b908 = undefined;
            var_d0b01271.var_aba63ea = undefined;
            var_d0b01271 notify(#"hash_6b33c66d373ab370");
          } else if(isDefined(var_cd34be2e.var_3480dd47) && isDefined(var_cd34be2e.var_1aa99c8b) && change > 0.5) {
            function_3d131a(localclientnum);
            var_d0b01271.var_c492e538 = var_cd34be2e.var_3480dd47;
            var_d0b01271.var_ae32b908 = model.origin;
            var_d0b01271.var_aba63ea = model.angles;

            if(isDefined(level.var_6365df1f)) {
              params = [[level.var_6365df1f]](localclientnum, var_d0b01271);
              params = function_923a14da(params, var_d0b01271);
              [[var_d0b01271]] - > update(params);
            } else {
              var_d0b01271 thread function_f7a5fba4(s_align, var_cd34be2e.str_scene, model, var_cd34be2e.var_3480dd47, var_cd34be2e.var_1aa99c8b);
            }

            var_41173053 = scene::function_8582657c(var_cd34be2e.str_scene, var_cd34be2e.var_3480dd47);
            wait var_41173053;
            var_d0b01271.var_c492e538 = undefined;
            var_d0b01271.var_ae32b908 = undefined;
            var_d0b01271.var_aba63ea = undefined;
            var_d0b01271 notify(#"hash_6b33c66d373ab370");
          }
        } else if(abs(change) > 0.0001) {
          function_3d131a(localclientnum);
          model.angles = (model.angles[0], absangleclamp360(model.angles[1] + change * 3), model.angles[2]);
        }
      }
    }

    waitframe(1);
  }
}

function function_f40eb809() {
  return isDefined(self.var_c492e538);
}

function private function_923a14da(params = spawnStruct(), var_d0b01271) {
  if(!isDefined(params.var_b1e821c5)) {
    params.var_b1e821c5 = spawnStruct();
  }

  if([[var_d0b01271]] - > function_ea4ac9f8() && [[var_d0b01271]] - > is_visible()) {
    params.var_b1e821c5.blend = 0.5;
  } else {
    params.var_b1e821c5.blend = 0;
  }

  return params;
}