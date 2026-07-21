/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_dwn_twn\cp_dwn_twn_objectives.gsc
********************************************************/

levelobjectives_init() {
  level.objectives_table = "_encstr_82741D7778186303B73DCB8588D94B26BE18FB2BB8C9CC5A0D45D2AD8EBF13";
  level.objectivesmatrixtable = "_encstr_B1C0241B835E8D07AF23DDCDAF8E77DC7DB7139ACA1B8ED2D995DC7DAD0B3A274BE1B8363767";
  level.objectiveregistration = ::levelregisterobjectives;

  if(scripts\engine\utility::flag_exist("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C"))
    scripts\engine\utility::flag_wait("_encstr_87331AEA936D67FBC04F8B63ED5802FB9868B2F2FB331FB5882D956C");

  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

levelregisterobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");

  if(!scripts\engine\utility::flag_exist("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9"))
    scripts\engine\utility::flag_init("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");

  scripts\engine\utility::flag_wait("_encstr_95D217A54E55D2EB03D84337513BA1EA0155211AA7CD0B35E9");

  if(isDefined(level.vault_assault_objective_func))
    [[level.vault_assault_objective_func]]();

  if(isDefined(level.mlp1_obj_func))
    [[level.mlp1_obj_func]]();

  if(isDefined(level.mlp3_obj_func))
    [[level.mlp3_obj_func]]();

  if(isDefined(level.rooftop_obj_func))
    [[level.rooftop_obj_func]]();

  if(isDefined(level.convoy_obj_func))
    [[level.convoy_obj_func]]();

  if(isDefined(level.mlp2_obj_func))
    [[level.mlp2_obj_func]]();

  if(isDefined(level.convoyescort_obj_func))
    [[level.convoyescort_obj_func]]();

  if(isDefined(level.safehouse_obj_func))
    [[level.safehouse_obj_func]]();
}