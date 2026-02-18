/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\encounters\aimappingtable.gsc
*****************************************************/

#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace aimappingtableutility;

function setmappingtableforteam(str_team, aimappingtable) {
  str_team = util::get_team_mapping(str_team);
  level.aimapppingtable[str_team] = aimappingtable;
}

function getspawnerforai(ai, team, str_mapping_table_override) {
  if(!isDefined(ai)) {
    return undefined;
  }

  aimappingtable = undefined;

  if(isDefined(str_mapping_table_override)) {
    aimappingtable = str_mapping_table_override;
  } else if(isDefined(level.aimapppingtable) && isDefined(level.aimapppingtable[team])) {
    aimappingtable = level.aimapppingtable[team];
  }

  if(!isDefined(aimappingtable)) {
    return undefined;
  }

  aimappingtablebundle = getscriptbundle(aimappingtable);

  if(!isDefined(aimappingtablebundle)) {
    return undefined;
  }

  aitype = aimappingtablebundle.("aitype_" + ai);

  if(isDefined(aitype)) {
    return aitype;
  }

  return aimappingtablebundle.("vehicle_" + ai);
}