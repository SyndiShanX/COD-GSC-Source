/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: destructible_scripts\electrical_transformer_large.gsc
*****************************************************************/

main() {
  common_scripts\_destructible::destructible_create("electrical_transformer_large", "tag_origin", 1500, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_splash_damage_scaler(2);
  common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
  common_scripts\_destructible::destructible_loopfx("tag_fx", "fx/explosions/electrical_transformer_spark_runner", 0.8);
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, undefined, 500, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
  common_scripts\_destructible::destructible_fx("tag_fx_junction", "fx/explosions/generator_sparks_c", 0);
  common_scripts\_destructible::destructible_loopfx("tag_fx_junction", "fx/fire/electrical_transformer_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_loopfx("tag_fx", "fx/explosions/electrical_transformer_spark_runner", 0.8);
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, undefined, 300, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
  common_scripts\_destructible::destructible_loopfx("tag_fx_junction", "fx/fire/electrical_transformer_blacksmoke_fire", 0.4);
  common_scripts\_destructible::destructible_loopfx("tag_fx", "fx/explosions/electrical_transformer_spark_runner", 0.8);
  common_scripts\_destructible::destructible_loopfx("tag_fx_valve", "fx/explosions/generator_spark_runner", 0.6);
  common_scripts\_destructible::destructible_healthdrain(12, 0.2, 210, "allies");
  common_scripts\_destructible::destructible_state(undefined, undefined, 500, undefined, 32, "no_melee");
  common_scripts\_destructible::destructible_fx("tag_death_fx", "fx/explosions/electrical_transformer_explosion", 0);
  common_scripts\_destructible::destructible_sound("electrical_transformer01_explode");
  common_scripts\_destructible::destructible_explode(6000, 8000, 210, 300, 20, 300, undefined, undefined, 0.3, 500);
  common_scripts\_destructible::destructible_state(undefined, "com_electrical_transformer_large_des", undefined, undefined, "no_melee");
  common_scripts\_destructible::destructible_part("tag_door1", "com_electrical_transformer_large_dam_door1", 1500, undefined, undefined, undefined, 0, 1.0, undefined, 1);
  common_scripts\_destructible::destructible_sound("electrical_transformer01_explode_detail");
  common_scripts\_destructible::destructible_fx("tag_door1", "fx/explosions/generator_explosion");
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_door2", "com_electrical_transformer_large_dam_door2", 150, undefined, undefined, undefined, 0, 1.0, undefined, 1);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_door3", "com_electrical_transformer_large_dam_door3", 150, undefined, undefined, undefined, 0, 1.0, undefined, 1);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_door4", "com_electrical_transformer_large_dam_door4", 150, undefined, undefined, undefined, 0, 1.0, undefined, 1);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_door5", "com_electrical_transformer_large_dam_door5", 1500, undefined, undefined, undefined, 0, 1.0, undefined, 1);
  common_scripts\_destructible::destructible_sound("electrical_transformer01_explode_detail");
  common_scripts\_destructible::destructible_fx("tag_door5", "fx/explosions/generator_explosion");
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_door6", "com_electrical_transformer_large_dam_door6", 150, undefined, undefined, undefined, 0, 1.0, undefined, 1);
  common_scripts\_destructible::destructible_physics();
  common_scripts\_destructible::destructible_part("tag_door7", "com_electrical_transformer_large_dam_door7", 150, undefined, undefined, undefined, 0, 1.0, undefined, 1);
  common_scripts\_destructible::destructible_loopsound("electrical_transformer_sparks");
  common_scripts\_destructible::destructible_fx("tag_door7", "fx/props/electricbox4_explode");
  common_scripts\_destructible::destructible_physics();
}