/********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\hometown\hometown_farah_trapped_anim.gsc
********************************************************************/

function farah_trapped_blend_anim_init() {
  level endon("carried_started");
  level.player normalizeworldupreferenceangles();
  farrah_anim_think(1);
}

#using_animtree("player");

function farrah_anim_think(var0) {
  level endon("carried_started");
  level.rail_player_model setanim(%htf_buri_010_rebar_hit_basepose, 1, 0, 1);
  level.buried_rebar_model linkTo(level.rail_player_model, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  linkplayertofarrah();
  thread animsdirectionalscrub(level.rail_player_model);
  thread animsdirectionalhit();
  level.rebar_hits = 0;

  while(level.rebar_hits <= 2) {
    waitframe();
  }
}

function linkplayertofarrah() {
  level endon("carried_started");
  var0 = level.rail_player_model scripts\engine\utility::spawn_tag_origin();
  var0 linkTo(level.rail_player_model, "tag_view", (0, 0, 0), (0, 0, 0));
  level.player hideviewmodel();
  level.player hidelegsandshadow();
  wait 0.5;
  level.player playersetgroundreferenceent(var0);
}

#using_animtree("");

function animsdirectionalscrub(var0) {
  level endon("carried_started");
  self setanim(%htf_buri_010_rebar_trans_r_to_l, 1, 0, 0);
  self setanim(%htf_buri_010_rebar_trans_u_to_d, 1, 0, 0);
  var1 = 0.5;
  var2 = 0.5;
  var3 = 0.5;
  var4 = 0.5;
  var5 = 0.25;
  var6 = 0.25;
  var7 = 0.04;

  for(;;) {
    var8 = level.player getnormalizedcameramovement();
    var9 = length(var8);
    var9 = clamp(var9, 0, 1);
    var10 = scripts\engine\math::factor_value(var5, var6, var9);

    if(var0) {
      var8 = (-1 * var8[0], -1 * var8[1], 0);
    } else {
      var8 = (var8[0], -1 * var8[1], 0);
    }

    var4 += var8[0] * var7;
    var3 += var8[1] * var7;
    var4 = clamp(var4, 0, 1);
    var3 = clamp(var3, 0, 1);
    var1 = scripts\engine\math::lerp(var1, var3, var10);
    var2 = scripts\engine\math::lerp(var2, var4, var10);
    self setcustomnodegameparameter("rebarhit_lr_scrub1d", var1);
    self setcustomnodegameparameter("rebarhit_ud_scrub1d", var2);
    var11 = scripts\engine\math::factor_value(1, -1, var1);
    var12 = scripts\engine\math::factor_value(1, -1, var2);
    self setcustomnodegameparameter("rebarhit_lr_blendspace2d", var11);
    self setcustomnodegameparameter("rebarhit_ud_blendspace2d", var12);
    waitframe();
  }
}

function animsdirectionalhit() {
  level endon("carried_started");
  self.debounce = 0;
  var0 = 0.2;
  var1 = getanimlength(%htf_buri_010_rebar_hit_c_player) - var0;
  self setanim(%htf_buri_010_rebar_idle_r_player);
  self setanim(%htf_buri_010_rebar_idle_c_player);
  self setanim(%htf_buri_010_rebar_idle_u_player);
  self setanim(%htf_buri_010_rebar_idle_l_player);
  self setanim(%htf_buri_010_rebar_idle_d_player);

  for(;;) {
    waitforattackbuttoninput();
    thread attackbuttondebounce();
    self setanimknob(%add_directional_hits, 0.999, var0);
    self setanimrestart(%htf_buri_010_rebar_hit_r_player, 1, var0);
    self setanimrestart(%htf_buri_010_rebar_hit_c_player, 1, var0);
    self setanimrestart(%htf_buri_010_rebar_hit_u_player, 1, var0);
    self setanimrestart(%htf_buri_010_rebar_hit_l_player, 1, var0);
    self setanimrestart(%htf_buri_010_rebar_hit_d_player, 1, var0);
    wait var1;
    self setanimknob(%add_directional_idles, 1, var0);
    wait 0.05;
    level.rebar_hits++;
  }
}

function waitforattackbuttoninput() {
  level endon("carried_started");

  while(self.debounce || !level.player attackButtonPressed()) {
    wait 0.05;
  }

  self.debounce = 1;
}

function attackbuttondebounce() {
  level endon("carried_started");

  while(level.player attackButtonPressed()) {
    wait 0.05;
  }

  self.debounce = 0;
}