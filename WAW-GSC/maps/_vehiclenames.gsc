/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehiclenames.gsc
**************************************/

main() {}

get_name() {
  american_names = 10;
  british_names = 18;
  russian_names = 10;

  if(!(isDefined(game["americanvehiclenames"]))) {
    game["americanvehiclenames"] = randomint(american_names);
  }
  if(!(isDefined(game["britishvehiclenames"]))) {
    game["britishvehiclenames"] = randomint(british_names);
  }
  if(!(isDefined(game["russianvehiclenames"]))) {
    game["russianvehiclenames"] = randomint(russian_names);
  }

  if(!isDefined(level.campaign)) {
    return;
  }

  if(level.campaign == "british") {
    game["britishvehiclenames"]++;
    get_british_name();
  } else
  if(level.campaign == "russian") {
    game["russianvehiclenames"]++;
    get_russian_name();
  } else {
    game["americanvehiclenames"]++;
    get_american_name();
  }
}

get_american_name() {
  vehiclename = undefined;
  switch (game["americanvehiclenames"]) {
    case1: vehiclename = ("Marauder");
    break;
    case2: vehiclename = ("Laughing Joe");
    break;
    case3: vehiclename = ("Detroit Iron");
    break;
    case4: vehiclename = ("Mississippi Mama");
    break;
    case5: vehiclename = ("Big Bertha");
    break;
    case6: vehiclename = ("Pacific Thunder");
    break;
    case 7:
      vehiclename = ("Five Day Express");
      break;
      case8: vehiclename = ("Thumper");
      break;
      case9: vehiclename = ("Wicked Witch");
      break;
      case10: vehiclename = ("Uncle Sam");
      game["americanvehiclenames"] = 0;
      break;
  }
  vehiclename = add_group_name(vehiclename);
  self setvehiclelookattext(vehiclename, level.vehicletypefancy[self.vehicletype]);
}

get_british_name() {
  vehiclename = undefined;
  switch (game["britishvehiclenames"]) {
    case 1:
      vehiclename = ("Gravedigger");
      break;
    case 2:
      vehiclename = ("Angel Maker");
      break;
    case 3:
      vehiclename = ("Cannonball");
      break;
    case 4:
      vehiclename = ("Lucky Lucy");
      break;
    case 5:
      vehiclename = ("Greta Garbo");
      break;
    case 6:
      vehiclename = ("Hole in One");
      break;
    case 7:
      vehiclename = ("Smokey");
      break;
    case 8:
      vehiclename = ("Untouchable");
      break;
    case 9:
      vehiclename = ("Hellcat");
      break;
      case10: vehiclename = ("Jerry's Medicine");
      break;
      case11: vehiclename = ("Her Majesty");
      break;
      case12: vehiclename = ("Storm Crow");
      break;
      case13: vehiclename = ("Dust Devil");
      break;
      case14: vehiclename = ("Homewrecker");
      break;
      case15: vehiclename = ("Jack the Ripper");
      break;
      case16: vehiclename = ("Divine Intervention");
      break;
      case17: vehiclename = ("Bloody Mary");
      break;
      case18: vehiclename = ("Pandemonium");
      game["britishvehiclenames"] = 0;
      break;
  }
  vehiclename = add_group_name(vehiclename);
  self setvehiclelookattext(vehiclename, level.vehicletypefancy[self.vehicletype]);
}
get_russian_name() {
  vehiclename = undefined;
  switch (game["russianvehiclenames"]) {
    case1: vehiclename = ("Kirovsky Factory No. " + RandomIntRange(100, 600));
    break;
    case2: vehiclename = ("Kharkov Locomotive Factory");
    break;
    case3: vehiclename = ("Ural Rail Works No. " + RandomIntRange(100, 600));
    break;
    case4: vehiclename = ("Nizhny Machine Factory No. " + RandomIntRange(100, 600));
    break;
    case5: vehiclename = ("Putilov Factory No. " + RandomIntRange(100, 600));
    break;
    case6: vehiclename = ("Tiger Tamer");
    break;
    case7: vehiclename = ("Rodina!");
    break;
    case8: vehiclename = ("Sasha's Chariot");
    break;
    case9: vehiclename = ("Moscow Military District");
    break;
    case10: vehiclename = ("29th Uralskaya Tank Corps");
    game["russianvehiclenames"] = 0;
    break;
  }
  vehiclename = add_group_name(vehiclename);
  self setvehiclelookattext(vehiclename, level.vehicletypefancy[self.vehicletype]);
}

add_group_name(vehiclename) {
  if(isDefined(self.script_tankgroup)) {
    vehiclename = self.script_tankgroup + ": " + vehiclename;
  }
  return vehiclename;
}