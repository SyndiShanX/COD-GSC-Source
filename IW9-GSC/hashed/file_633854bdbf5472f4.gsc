/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_633854bdbf5472f4.gsc
***********************************************/

_id_FA8DDEAA2A6BB272() {
  if(isDefined(level._id_76CE39572BE8612F)) {
    return;
  }
  level._id_76CE39572BE8612F = spawnStruct();
  level._id_76CE39572BE8612F._id_591DA62720EE88E6 = getdvarfloat("dvar_EAABB9738BAADE1B", 0.95);
  level._id_76CE39572BE8612F._id_06A38503F9E58ED7 = getdvarfloat("dvar_009560E41A09192E", 275);
  level._id_76CE39572BE8612F._id_35217D5234F62F8E = 1;
  level._id_76CE39572BE8612F._id_B7D6A53FBF52476F = getdvarint("dvar_64840DA6A37212FD", 1);
  level._id_76CE39572BE8612F._id_C65D27D5AE3771B2 = getdvarint("dvar_10BDA10864F4CFD0", 1);
  level._id_76CE39572BE8612F._id_12A608CA0CD0E255 = getdvarint("dvar_3A6713FE2E446357", 1);
  level._id_76CE39572BE8612F._id_85B5364DCE3559B9 = getdvarint("dvar_0F0BCCE2D8ADBA06", 15);
  level._id_76CE39572BE8612F._id_E5BE1BDE95892EAD = getdvarint("dvar_1F9DE6E2E594ADA6", 20);
  level._id_76CE39572BE8612F._id_CC3C06522B8610D5 = getdvarint("dvar_23104B4327890D08", 35);
  level._id_76CE39572BE8612F._id_4DB34FEBAC47F914 = getdvarfloat("dvar_B6752D2CBFE301BB", 0.4);
  level._id_76CE39572BE8612F._id_D372E2316F390A27 = getdvarfloat("dvar_EBC996E3BD891C88", 0.25);
  level._id_76CE39572BE8612F._id_2014415ABA41B18E = getdvarint("dvar_0429A06F8169F988", 1);
  level._id_76CE39572BE8612F._id_E77806D8E9E70420 = getdvarfloat("dvar_F4A0DE7BEC40EF7A", 5.0);
  level._id_76CE39572BE8612F._id_3F20AAF8B5647B32 = 0;
  level._id_FA9FFDF05522A236 = "gas_on_death";
  level._id_65312A3DF9AE3174 = "explosion_on_death";
  level._id_65312A3DF9AE3174 = "emp";
  level._id_81406583DCF98219 = "weakpoint";
  level._id_9413627766AAE4FC = "ranger";
  level._id_8E966244F7680884 = "base";
  level._effect["zmb_ai_crawling_out_of_ground"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_spawn_ground.vfx");
  level._effect["zmb_ai_crawling_out_of_vent"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_spawn_vent.vfx");
  level._effect["zmb_ai_base_death"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  level._effect["zmb_ai_gas_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_gas_death.vfx");
  level._effect["zmb_ai_explosion_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_explode_death.vfx");
  level._effect["zmb_ai_emp_charge"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_amb_pulse_chargeup.vfx");
  level._effect["zmb_ai_emp_pulse"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_amb_pulse.vfx");
  level._effect["zmb_ai_emp_death"] = loadfx("vfx/iw8_br/gameplay/zombie_ai/vfx_zai_emp_death.vfx");
  level._effect["zmb_ai_weakpoint_death"] = loadfx("vfx/iw8/weap/_impact/flesh/vfx_imp_flesh_fatal_med.vfx");
  thread _id_36D32BDDDE2A5ED3();
}

_id_36D32BDDDE2A5ED3() {
  wait 5.0;
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("br_zmb_sfx");
}

_id_40302A0B243C15C7() {
  zombie = self;
  level endon("game_ended");
  zombie endon("death");
  zombie endon("terminate_ai_threads");
  zombie hide();
  wait 0.2;
  zombie show();
}

_id_97B1A95CB1211761() {
  return getdvarint("dvar_BE0E2BD2641EE4D3", 0) > 0;
}

_id_40658AF2B14C86E6(aitype, position, angles, spawner, _id_521FAC03E5F3A11B, _id_8216C9148D9CF617) {
  if(!scripts\engine\utility::string_starts_with(aitype, "actor_"))
    aitype = "actor_" + aitype;

  if(!isDefined(level.agent_definition[aitype]))
    return undefined;

  if(!isDefined(spawner)) {
    spawner = spawnStruct();
    spawner.script_animation = "spawn_ground";
    spawner.targetname = "spawnStruct";
    spawner.origin = position;
  }

  if(isDefined(spawner) && isDefined(spawner.targetname))
    _id_B8B20E6499F73EE0("Zombie will spawn At " + spawner.targetname);

  priority = "medium";
  category = "zombies";
  _id_1C9CB43BCF3EB16D = "zombie";
  groupname = undefined;
  _id_FABF84450735DD93 = "team_two_hundred";
  destination = undefined;
  _id_171F90B9C4C76D44 = _id_8216C9148D9CF617;
  _id_F891E067B8802C0D = 1;
  _id_5A6A87FA3F95753F = 0;
  _id_5F0C541B305BF851 = 0;
  agent = _id_48814951E916AF89::_id_EA94A8BF24D3C5EF(aitype, position, angles, priority, category, _id_1C9CB43BCF3EB16D, groupname, _id_FABF84450735DD93, destination, _id_171F90B9C4C76D44, _id_F891E067B8802C0D, _id_5A6A87FA3F95753F, _id_5F0C541B305BF851);

  if(isDefined(agent)) {
    _id_B8B20E6499F73EE0("Spawned zombie : " + aitype);
    agent.spawner = spawner;
    agent.agentname = &"MP_ZXP/ZOMBIE";
    agent thread _id_40302A0B243C15C7();

    if(isDefined(_id_521FAC03E5F3A11B)) {
      agent._id_521FAC03E5F3A11B = _id_521FAC03E5F3A11B;

      switch (_id_521FAC03E5F3A11B) {
        case "base":
        default:
          playsoundatpos(agent.origin, "zmb_spawn_type_default");
          break;
        case "ranger":
        case "gas_on_death":
          playsoundatpos(agent.origin, "zmb_spawn_type_gas");
          break;
        case "explosion_on_death":
          playsoundatpos(agent.origin, "zmb_spawn_type_exp");
          break;
        case "emp":
          playsoundatpos(agent.origin, "zmb_spawn_type_emp");
          break;
        case "weakpoint":
          agent thread _id_F09ACE9915D15F2E("c_t9_zmb_ndu_zombie_honorguard_helmet_barbed", "j_helmet");
          playsoundatpos(agent.origin, "zmb_spawn_type_armor");
          break;
      }
    }

    if(!isDefined(spawner._id_BC2DBD2D565FD393))
      spawner._id_BC2DBD2D565FD393 = getclosestpointonnavmesh(spawner.origin);

    if(isDefined(spawner.script_animation)) {
      switch (spawner.script_animation) {
        case "spawn_wall_low":
          if(isDefined(level._effect["zmb_ai_crawling_out_of_vent"]))
            playFX(level._effect["zmb_ai_crawling_out_of_vent"], agent.origin);

          break;
        case "spawn_ground":
        default:
          if(isDefined(level._effect["zmb_ai_crawling_out_of_ground"])) {
            _id_214D77BB9D513C28 = scripts\engine\trace::ray_trace(agent.origin, agent.origin - (0, 0, 500));
            _id_8B0143A72823A7B1 = _id_214D77BB9D513C28["normal"];
            _id_24D4ADBE595ACFEA = _id_214D77BB9D513C28["position"];
            _id_F29B7EB46164B689 = vectorcross(_id_8B0143A72823A7B1, (1, 0, 0));

            if(_id_8B0143A72823A7B1 == (0, 0, 0))
              playFX(scripts\engine\utility::getfx("zmb_ai_crawling_out_of_ground"), _id_24D4ADBE595ACFEA);
            else
              playFX(scripts\engine\utility::getfx("zmb_ai_crawling_out_of_ground"), _id_24D4ADBE595ACFEA, _id_F29B7EB46164B689, _id_8B0143A72823A7B1);
          }

          break;
      }
    }
  } else
    _id_B8B20E6499F73EE0("Spawn Failed " + aitype);

  return agent;
}

_id_F09ACE9915D15F2E(helmet, tag, _id_6AEB198F91E2077E) {
  level endon("zai_round_over");
  level endon("game_ended");
  self endon("terminate_ai_threads");

  if(!istrue(_id_6AEB198F91E2077E))
    wait 0.25;

  self attach(helmet, tag);
  self.hashelmet = 1;
  self._id_02749A2A95446437 = spawnStruct();
  self._id_02749A2A95446437.model = helmet;
  self._id_02749A2A95446437.tag = tag;
}

_id_E9C30B87B59D7B2D(helmet, tag) {
  self detach(self._id_02749A2A95446437.model, self._id_02749A2A95446437.tag);
  self.hashelmet = 0;
  self._id_02749A2A95446437 = undefined;
}

_id_B8B20E6499F73EE0(message) {}