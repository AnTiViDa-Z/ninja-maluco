extends CharacterBody2D
class_name PersonagemBase

enum Personagens {
	EggBoy = 0, Hunter = 1, MaskRacoon = 2,
	RobotCamouflage = 3, Cavegirl2 = 4, Princess = 5, Woman = 6, SorcererBlack = 7, AnTiViDa = 8,
}

var _ataque_selecionado: String = ""
var _prefixo_animacao: String = "_b"

var _pode_atacar: bool = true
var _atacando: bool = false

@export_category("Objetos")
@export var _animator: AnimationPlayer
@export var _textura:Sprite2D

@export_category("Vaiaveis")
@export var _personagem_selecionado: Personagens
@export var _codigo_personagem: Array[String]

func _ready() -> void:
	_textura.texture = load(
		"res://Actor/Character/" + _codigo_personagem[_personagem_selecionado] + "/SpriteSheet.png"
	)
	
	
func _physics_process(_delta: float) -> void:
	var direcao: Vector2 = Input.get_vector(
		"mover_e", "mover_d", "mover_c", "mover_b"
	)
	
	if Input.is_action_pressed("mover_e") and direcao.x != 0:
		_prefixo_animacao = "_e"
		
	if Input.is_action_pressed("mover_d") and direcao.x != 0:
		_prefixo_animacao = "_d"
		
	if Input.is_action_pressed("mover_b") and direcao.y != 0:
		_prefixo_animacao = "_b"
		
	if Input.is_action_pressed("mover_c") and direcao.y != 0:
		_prefixo_animacao = "_c"
	
	velocity = direcao * 64.0
	move_and_slide()
	
	if Input.is_action_just_pressed("ataque") and _pode_atacar:
		_ataque_selecionado = "ataque" + _prefixo_animacao
		set_physics_process(false)
		_pode_atacar = false
		_atacando = true
		
	elif Input.is_action_just_pressed("ataque_especial_1") and _pode_atacar:
		_ataque_selecionado = "ataque_especial_1"
		set_physics_process(false)
		_pode_atacar = false
		_atacando = true
		
	elif Input.is_action_just_pressed("ataque_especial_2") and _pode_atacar:
		_ataque_selecionado = "ataque_especial_2"
		set_physics_process(false)
		_pode_atacar = false
		_atacando = true
		
	_animar()
	
	
func _animar() -> void:
	if _atacando == true:
		_animator.play(_ataque_selecionado)
		
	elif velocity == Vector2.ZERO:
		_animator.play("parado" + _prefixo_animacao)
		
	elif velocity != Vector2.ZERO:
		_animator.play("andando" + _prefixo_animacao)


func _quando_animacao_terminar(_anim_name: StringName) -> void:
	if _anim_name.contains("ataque"):
		_atacando = false
		_pode_atacar = true
		set_physics_process(true)
