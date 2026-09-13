/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6de96568512eb1ca.gsc
***********************************************/

main() {
  if(getdvarint("dvar_DA6B87817DB1CBA0", 0) == 0) {
    return;
  }
  if(getdvarint("dvar_B4866A8ED52FBD69", 1) != 0) {
    return;
  }
  wait 5;
  initializerocketfuelreadings();
  registerpuzzleinteractions();
  resetchemicalvalvevalues();
  calculateandsettotalfuel();
  setupoptimalreadinghint();
  level thread fuelsequencestability();
}

fuelsequencestability() {
  for(;;) {
    level waittill("stability_changed", _id_E3108E412AFB3811);

    if(istrue(_id_E3108E412AFB3811))
      continue;
  }
}

registerpuzzleinteractions() {
  scripts\cp\cp_interaction::registerinteraction("seq_button", ::hint_seq_button, ::activate_seq_button, ::init_seq_button, 0, "duration_long");
}

init_seq_button(_id_70DAB3207FB65169) {
  if(_id_70DAB3207FB65169.size > 0) {
    foreach(struct in _id_70DAB3207FB65169) {
      headicon = "icon_electronic_interact";

      switch (struct.script_label) {
        case "A":
          headicon = "icon_electronic_interact";
          break;
        case "B":
          headicon = "icon_electronic_interact";
          break;
        case "C":
          headicon = "hud_icon_perk_medic_pro";
          break;
        case "D":
          headicon = "hud_icon_perk_medic_pro";
          break;
        case "E":
          headicon = "hud_icon_digit";
          break;
        case "F":
          headicon = "hud_icon_hardpoint_diamond";
          break;
        case "G":
          headicon = "hud_icon_hardpoint_diamond";
          break;
        case "H":
          headicon = "hud_icon_perk_momentum_pro";
          break;
        case "I":
          headicon = "hud_icon_sng_intel";
          break;
        case "J":
          headicon = "cp_crate_icon_armor";
          break;
      }

      struct.blocked = 0;
      struct.model = spawn("script_model", struct.origin);
      struct.headicon = createheadicon(struct.model);
      setheadiconimage(struct.headicon, headicon);
      setheadiconzoffset(struct.headicon, 5);
      setheadiconsnaptoedges(struct.headicon, 0);
      setheadicondrawthroughgeo(struct.headicon, 1);
      setheadiconmaxdistance(struct.headicon, 5000);
      setheadiconnaturaldistance(struct.headicon, 500);
    }
  }
}

hint_seq_button(_id_DF071553D0996FF9, player) {
  if(istrue(_id_DF071553D0996FF9.blocked))
    return "";

  return &"CP_RAID_COMPLEX_JUGG_MAZE/ADJUST_GAUGE";
}

activate_seq_button(_id_DF071553D0996FF9, player) {
  player endon("disconnect");

  if(istrue(_id_DF071553D0996FF9.blocked)) {
    return;
  }
  switch (_id_DF071553D0996FF9.script_label) {
    case "A":
      level.rocket_fuel_x1.polarity = level.rocket_fuel_x1.polarity * -1;
      player iprintln(" Polarity = ^1 " + level.rocket_fuel_x1.polarity);
      break;
    case "B":
      level.rocket_fuel_x2.polarity = level.rocket_fuel_x2.polarity * -1;
      player iprintln(" Polarity = ^1 " + level.rocket_fuel_x2.polarity);
      break;
    case "C":
      level.rocket_fuel_x1.reading = level.rocket_fuel_x1.reading + level.rocket_fuel_x1.increment_factor * level.rocket_fuel_x1.polarity;
      level.rocket_fuel_x1.value = abs(level.rocket_fuel_x1.reading);
      player iprintln(" Element X1 Reading = ^1 " + level.rocket_fuel_x1.reading);
      level.rocket_fuel_x2.reading = level.rocket_fuel_x2.reading + level.rocket_fuel_x2.increment_factor * (level.rocket_fuel_x2.polarity * -1);
      level.rocket_fuel_x2.value = abs(level.rocket_fuel_x2.reading);
      player iprintln(" Element X2 Reading = ^1 " + level.rocket_fuel_x2.reading);
      break;
    case "D":
      level.rocket_fuel_x2.reading = level.rocket_fuel_x2.reading + level.rocket_fuel_x2.increment_factor * level.rocket_fuel_x2.polarity;
      level.rocket_fuel_x2.value = abs(level.rocket_fuel_x2.reading);
      player iprintln(" Element X2 Reading = ^1 " + level.rocket_fuel_x2.reading);
      level.rocket_fuel_x1.reading = level.rocket_fuel_x1.reading + level.rocket_fuel_x1.increment_factor * (level.rocket_fuel_x1.polarity * -1);
      level.rocket_fuel_x1.value = abs(level.rocket_fuel_x1.reading);
      player iprintln(" Element X1 Reading = ^1 " + level.rocket_fuel_x1.reading);
      break;
    case "E":
      resetchemicalvalvevalues();
      player iprintln(" ^3 Values Reset! Element X1 = ^1" + level.rocket_fuel_x1.reading + " ^3 Element X2 = ^1" + level.rocket_fuel_x2.reading);
      break;
    case "F":
      _id_BFB5889E9627B098 = scripts\engine\utility::array_remove([0, 1, 5, 10, 50, 75], level.rocket_fuel_x1.increment_factor);
      level.rocket_fuel_x1.increment_factor = scripts\engine\utility::random(_id_BFB5889E9627B098);
      player iprintln(" Element X1 Increment Factor = ^1 " + level.rocket_fuel_x1.increment_factor);
      break;
    case "G":
      _id_BFB5889E9627B098 = scripts\engine\utility::array_remove([0, 1, 5, 10, 50, 75], level.rocket_fuel_x2.increment_factor);
      level.rocket_fuel_x2.increment_factor = scripts\engine\utility::random(_id_BFB5889E9627B098);
      player iprintln(" Element X2 Increment Factor = ^1 " + level.rocket_fuel_x2.increment_factor);
      break;
    case "H":
      if(havefuellevelsreachedoptimalvalue()) {
        foreach(struct in scripts\engine\utility::getStructArray("seq_button", "script_noteworthy"))
        deleteheadicon(struct.headicon);

        level notify("progress_level");
        scripts\cp\cp_interaction::remove_from_current_interaction_list(_id_DF071553D0996FF9);
        return;
      }

      break;
    case "I":
      level.rocket_fuel_x1.value = randomintrange(1, 100);
      level.rocket_fuel_x2.value = randomintrange(1, 100);
      level.rocket_fuel_x1.reading = level.rocket_fuel_x1.value * level.rocket_fuel_x1.polarity;
      level.rocket_fuel_x2.reading = level.rocket_fuel_x2.value * level.rocket_fuel_x2.polarity;
      player iprintln(" ^3 Values ^4Randomized! ^3Element X1 = ^1" + level.rocket_fuel_x1.reading + " ^3 Element X2 = ^1" + level.rocket_fuel_x2.reading);
      break;
    case "J":
      player iprintln(" ^3 Current Reading - ^2 Element X1 = ^1" + level.rocket_fuel_x1.reading + " ^2 Element X2 = ^1" + level.rocket_fuel_x2.reading);
      break;
  }

  calculateandvalidatefuelstability();
  calculateandsettotalfuel();
}

havefuellevelsreachedoptimalvalue() {
  if(level.rocket_fuel_x1.reading == 5 && level.rocket_fuel_x2.reading == 1)
    return 1;
  else
    return 0;
}

fluctuatevalues() {
  for(;;) {
    level scripts\engine\utility::waittill_any_timeout_1(1, "fuel_values_changed");
    setomnvar("ui_chemical_1_amount", randomintrange(1, 100));
    setomnvar("ui_chemical_2_amount", randomintrange(1, 100));
    setomnvar("ui_chemical_3_amount", randomintrange(1, 100));
    setomnvar("ui_chemical_4_amount", randomintrange(1, 100));
    calculateandsettotalfuel();
  }
}

validatefuelstability(a, b, c, _id_AC0E564AC96A9D0F) {
  if(a >= 10 && b >= 12 && c >= 6 && _id_AC0E564AC96A9D0F == 1) {
    setomnvar("ui_chemical_1_stability", 0);
    setomnvar("ui_chemical_2_stability", 0);
    setomnvar("ui_chemical_3_stability", 0);
    setomnvar("ui_chemical_4_stability", 0);
    return 1;
  }

  if(a < 10)
    setomnvar("ui_chemical_1_stability", 1);

  if(b < 12)
    setomnvar("ui_chemical_2_stability", 1);

  if(c < 6)
    setomnvar("ui_chemical_3_stability", 1);

  if(_id_AC0E564AC96A9D0F != 1)
    setomnvar("ui_chemical_4_stability", 1);

  return 0;
}

calculateandsettotalfuel() {
  if(istrue(level.rocket_fuel_stability)) {
    _id_E3F3F4E8BE2E07AF = level.rocket_fuel_x1.reading + 2 * level.rocket_fuel_x2.reading;
    setomnvar("ui_rocket_fuel_total", int(scripts\engine\utility::ter_op(_id_E3F3F4E8BE2E07AF < 0, 0, _id_E3F3F4E8BE2E07AF)));
  } else {
    _id_E3F3F4E8BE2E07AF = level.rocket_fuel_x1.reading + 2 * level.rocket_fuel_x2.reading;
    setomnvar("ui_rocket_fuel_total", int(scripts\engine\utility::ter_op(_id_E3F3F4E8BE2E07AF < 0, 0, _id_E3F3F4E8BE2E07AF)));
  }
}

setupoptimalreadinghint() {
  _id_E3F3F4E8BE2E07AF = 7;
  setomnvar("ui_rocket_fuel_stability", _id_E3F3F4E8BE2E07AF);
}

resetchemicalvalvevalues() {
  level.rocket_fuel_x1.value = 40;
  level.rocket_fuel_x1.polarity = 1;
  level.rocket_fuel_x1.reading = level.rocket_fuel_x1.value * level.rocket_fuel_x1.polarity;
  level.rocket_fuel_x2.value = 80;
  level.rocket_fuel_x2.polarity = 1;
  level.rocket_fuel_x2.reading = level.rocket_fuel_x2.value * level.rocket_fuel_x2.polarity;
  level.rocket_fuel_stability = 1;
  a = level.rocket_fuel_x1.reading + 5 * level.rocket_fuel_x2.reading;
  b = 3 * level.rocket_fuel_x1.reading + level.rocket_fuel_x2.reading;
  c = level.rocket_fuel_x1.reading + level.rocket_fuel_x2.reading;
  _id_AC0E564AC96A9D0F = level.rocket_fuel_x1.reading >= 0 && level.rocket_fuel_x1.reading <= 100 && (level.rocket_fuel_x2.reading >= 0 && level.rocket_fuel_x2.reading <= 100);
  level.rocket_fuel_stability = validatefuelstability(a, b, c, _id_AC0E564AC96A9D0F);
  setomnvar("ui_chemical_1_amount", a);
  setomnvar("ui_chemical_2_amount", b);
  setomnvar("ui_chemical_3_amount", c);

  if(istrue(_id_AC0E564AC96A9D0F))
    setomnvar("ui_chemical_4_amount", _id_AC0E564AC96A9D0F * 100);
  else
    setomnvar("ui_chemical_4_amount", _id_AC0E564AC96A9D0F * 50);
}

calculateandvalidatefuelstability() {
  a = level.rocket_fuel_x1.reading + 5 * level.rocket_fuel_x2.reading;
  b = 3 * level.rocket_fuel_x1.reading + level.rocket_fuel_x2.reading;
  c = level.rocket_fuel_x1.reading + level.rocket_fuel_x2.reading;
  _id_AC0E564AC96A9D0F = level.rocket_fuel_x1.reading >= 0 && level.rocket_fuel_x1.reading <= 100 && (level.rocket_fuel_x2.reading >= 0 && level.rocket_fuel_x2.reading <= 100);
  level.rocket_fuel_stability = validatefuelstability(a, b, c, _id_AC0E564AC96A9D0F);
  setomnvar("ui_chemical_1_amount", int(scripts\engine\utility::ter_op(a < 0, 0, a)));
  setomnvar("ui_chemical_2_amount", int(scripts\engine\utility::ter_op(b < 0, 0, b)));
  setomnvar("ui_chemical_3_amount", int(scripts\engine\utility::ter_op(c < 0, 0, c)));

  if(istrue(_id_AC0E564AC96A9D0F))
    setomnvar("ui_chemical_4_amount", _id_AC0E564AC96A9D0F * 100);
  else
    setomnvar("ui_chemical_4_amount", _id_AC0E564AC96A9D0F * 50);
}

initializerocketfuelreadings() {
  level.rocket_fuel_x1 = spawnStruct();
  level.rocket_fuel_x1.value = 4;
  level.rocket_fuel_x1.polarity = 1;
  level.rocket_fuel_x1.increment_factor = 1;
  level.rocket_fuel_x1.reading = level.rocket_fuel_x1.value * level.rocket_fuel_x1.polarity;
  level.rocket_fuel_x2 = spawnStruct();
  level.rocket_fuel_x2.value = 8;
  level.rocket_fuel_x2.polarity = 1;
  level.rocket_fuel_x2.increment_factor = 1;
  level.rocket_fuel_x2.reading = level.rocket_fuel_x2.value * level.rocket_fuel_x2.polarity;
}