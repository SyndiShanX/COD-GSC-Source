/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_dwntwn_crane.gsc
***********************************************/

min_x() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  min_z();
  level thread min_y();
}

min_z() {
  level.min_x = getEnt("_encstr_A37C0A4F250F5ADD49813AC5", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.min_x.collision = getEnt("_encstr_86261061AA17D657C91030F84C48CB4B608D", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.min_x.spawn_maint_wave_2 = getEnt("_encstr_A31F0BEE5A3612B81748D75F9A", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.min_x._id_123B7 = getEnt("_encstr_AFAE0F36932CCDCABEE063B0A399BDE4B6", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.min_x.collision linkTo(level.min_x);
  level.min_x.trigger = getEnt("_encstr_A9BC0E324BB7B357E9F15241FF3B1F9B", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.min_x.trigger makeusable();
  level.min_x.trigger show();
  level.min_x.trigger sethintdisplayfov(360);
  level.min_x.trigger setusefov(360);
  level.min_x.trigger sethintdisplayrange(100);
  level.min_x.trigger setuserange(100);
  var_0 = getEnt(level.min_x.spawn_maint_wave_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = getEnt(var_0.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  level.min_x._id_11E30 = var_0;
  level.min_x.pelletweaponvictimids = var_1;
  level.min_x._id_11E30 linkTo(level.min_x);
  level.min_x.pelletweaponvictimids linkTo(level.min_x);
}

min_y() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.min_x endon("_encstr_AD75063D571AE108");
  level.min_x endon("_encstr_8BE208E31FA8E1631D65");
  level.min_x.trigger endon("_encstr_BE750667D1701033");

  for(;;) {
    if(isDefined(level.min_x.trigger)) {
      level.min_x.trigger.in_use = undefined;
      level.min_x.trigger makeusable();
      level.min_x.trigger setHintString(&"_encstr_854221ED01DA36E3AF9C588165FEE73E598B5A64B3D1897FAEB550980ED753E539D1C4");
      level.min_x.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
      level.min_x.trigger.in_use = 1;
      level.min_x.trigger makeunusable();
      level.min_x.trigger setHintString("_encstr_B40101");
      var_0 playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
    }

    wait 5;
    level.min_x._id_123B7 movez(1808, 5, 1, 1);
    wait 7;
    level.min_x._id_123B7 linkTo(level.min_x.spawn_maint_wave_2);
    level.min_x.spawn_maint_wave_2 moveTo(level.min_x.pelletweaponvictimids.origin, 5, 1, 1);
    wait 7;
    level.min_x.spawn_maint_wave_2 linkTo(level.min_x);
    level.min_x rotateYaw(135, 10, 1, 1);
    wait 12;

    if(isDefined(level.min_x.trigger)) {
      level.min_x.trigger.in_use = undefined;
      level.min_x.trigger makeusable();
      level.min_x.trigger setHintString(&"_encstr_854221ED01DA36E3AF9C588165FEE73E598B5A64B3D1897FAEB550980ED753E539D1C4");
      level.min_x.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_0);
      level.min_x.trigger.in_use = 1;
      level.min_x.trigger makeunusable();
      level.min_x.trigger setHintString("_encstr_B40101");
      var_0 playlocalsound("_encstr_A3C80F4AF0E9DFB1709519F44369C36705");
    }

    wait 5;
    level.min_x rotateYaw(-135, 10, 1, 1);
    wait 12;
    level.min_x.spawn_maint_wave_2 unlink();
    level.min_x.spawn_maint_wave_2 moveTo(level.min_x._id_11E30.origin, 5, 1, 1);
    wait 7;
    level.min_x._id_123B7 unlink();
    level.min_x._id_123B7 movez(-1808, 5, 1, 1);
    wait 7;
  }
}