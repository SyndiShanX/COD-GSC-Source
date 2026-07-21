/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\hometown\hometown_farah_trapped_anim.gsc
************************************************************/

farah_trapped_blend_anim_init() {
  level endon("carried_started");
  level.player normalizeworldupreferenceangles();
  farrah_anim_think(1);
}

#using_animtree("player");

farrah_anim_think(var_0) {
  level endon("carried_started");
  level.rail_player_model setanim(%htf_buri_010_rebar_hit_basepose, 1, 0, 1);
  level.buried_rebar_model linkTo(level.rail_player_model, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  linkplayertofarrah();
  level.rail_player_model thread animsdirectionalscrub(var_0);
  level.rail_player_model thread animsdirectionalhit();
  level.rebar_hits = 0;

  while(level.rebar_hits <= 2)
    waitframe();
}

linkplayertofarrah() {
  level endon("carried_started");
  var_0 = level.rail_player_model scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level.rail_player_model, "tag_view", (0, 0, 0), (0, 0, 0));
  level.player hideviewmodel();
  level.player hidelegsandshadow();
  wait 0.5;
  level.player playersetgroundreferenceent(var_0);
}

animsdirectionalscrub(var_0) {
  level endon("carried_started");
  self setanim(%htf_buri_010_rebar_trans_r_to_l, 1, 0, 0.0);
  self setanim(%htf_buri_010_rebar_trans_u_to_d, 1, 0, 0.0);
  var_1 = 0.5;
  var_2 = 0.5;
  var_3 = 0.5;
  var_4 = 0.5;
  var_5 = 0.25;
  var_6 = 0.25;
  var_7 = 0.04;

  for(;;) {
    var_8 = level.player getnormalizedcameramovement();
    var_9 = length(var_8);
    var_9 = clamp(var_9, 0, 1);
    var_10 = scripts\engine\math::factor_value(var_5, var_6, var_9);

    if(var_0)
      var_8 = (-1 * var_8[0], -1 * var_8[1], 0);
    else
      var_8 = (var_8[0], -1 * var_8[1], 0);

    var_4 = var_4 + var_8[0] * var_7;
    var_3 = var_3 + var_8[1] * var_7;
    var_4 = clamp(var_4, 0, 1);
    var_3 = clamp(var_3, 0, 1);
    var_1 = scripts\engine\math::lerp(var_1, var_3, var_10);
    var_2 = scripts\engine\math::lerp(var_2, var_4, var_10);
    self setcustomnodegameparameter("rebarhit_lr_scrub1d", var_1);
    self setcustomnodegameparameter("rebarhit_ud_scrub1d", var_2);
    var_11 = scripts\engine\math::factor_value(1, -1, var_1);
    var_12 = scripts\engine\math::factor_value(1, -1, var_2);
    self setcustomnodegameparameter("rebarhit_lr_blendspace2d", var_11);
    self setcustomnodegameparameter("rebarhit_ud_blendspace2d", var_12);
    waitframe();
  }
}

animsdirectionalhit() {
  level endon("carried_started");
  self.debounce = 0;
  var_0 = 0.2;
  var_1 = getanimlength(%htf_buri_010_rebar_hit_c_player) - var_0;
  self setanim(%htf_buri_010_rebar_idle_r_player);
  self setanim(%htf_buri_010_rebar_idle_c_player);
  self setanim(%htf_buri_010_rebar_idle_u_player);
  self setanim(%htf_buri_010_rebar_idle_l_player);
  self setanim(%htf_buri_010_rebar_idle_d_player);

  for(;;) {
    waitforattackbuttoninput();
    thread attackbuttondebounce();
    self setanimknob(%add_directional_hits, 0.999, var_0);
    self setanimrestart(%htf_buri_010_rebar_hit_r_player, 1, var_0);
    self setanimrestart(%htf_buri_010_rebar_hit_c_player, 1, var_0);
    self setanimrestart(%htf_buri_010_rebar_hit_u_player, 1, var_0);
    self setanimrestart(%htf_buri_010_rebar_hit_l_player, 1, var_0);
    self setanimrestart(%htf_buri_010_rebar_hit_d_player, 1, var_0);
    wait(var_1);
    self setanimknob(%add_directional_idles, 1, var_0);
    wait 0.05;
    level.rebar_hits++;
  }
}

waitforattackbuttoninput() {
  level endon("carried_started");

  while(self.debounce || !level.player attackButtonPressed())
    wait 0.05;

  self.debounce = 1;
}

attackbuttondebounce() {
  level endon("carried_started");

  while(level.player attackButtonPressed())
    wait 0.05;

  self.debounce = 0;
}