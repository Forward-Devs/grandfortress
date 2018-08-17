/* Actor Model */
#define Actor::%0(%1) Actor[%0][Actor_%1] // Usage: Actor::1(skin) | Return skin of actor ID 1

enum E_ACTORS
{
	ORM: Actor_ORM_ID,

	Actor_id,
	Actor_actor,
	Actor_name[MAX_PLAYER_NAME],
	Actor_type,
	Actor_skin,
	Float:Actor_xPos,
	Float:Actor_yPos,
	Float:Actor_zPos,
	Float:Actor_aPos,
	Actor_interior,
	Actor_invulnerable,
	Float:Actor_health,

	Text3D:Actor_ActorText,
};
new Actor[MAX_ACTORS][E_ACTORS];