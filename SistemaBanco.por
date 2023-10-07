programa
{
	inclua biblioteca Texto --> t
	inclua biblioteca Util --> u
	inclua biblioteca Matematica --> m
	inclua biblioteca Arquivos --> a
	
	const cadeia MSG_SEM_SALDO = "Saldo Insuficiente!"
	const cadeia LOGIN_CORRETO = "Aluno"
	const cadeia SENHA_CORRETA = "Proway"
	const inteiro TAMANHO_PADRAO = 7
	
	inteiro TEMPO_PADRAO = 2000
	cadeia login = "", senha = "", conta = "", contaDestino = ""
	inteiro opcao = 0, tempo = 0
	inteiro cont
	logico existeConta = falso
	real valor = 0., SaldoContaA = 0., SaldoContaB = 0.
	cadeia mensagemFinal = "\nObrigado por usar o sistema"
	cadeia senhaAdm

	cadeia contas[] = {"1234567","7654321"}

	funcao Configuracao(inteiro pTempo)
	{
		escreva("Senha de Acesso para Configuração: ")
		leia( senhaAdm )
		se ( senhaAdm == "Administrador" )
		{
			escreva("Mensagem de encerramento: ")
			leia(mensagemFinal)
			TEMPO_PADRAO = pTempo * 1000
		}
		senao
			EscrevaEAguarde("Senha de ADM INVALIDA!",TEMPO_PADRAO)
	}
	
	funcao logico ExisteConta(cadeia pConta, logico pMostraMsg)
	{
		para (cont = 0; cont <= u.numero_elementos(contas) -1; cont++)
		{
			existeConta = contas[cont] == pConta
			se ( existeConta )
			{
				retorne verdadeiro
			}
			senao
			{
				se (cont == u.numero_elementos(contas) -1)
				{
					se (pMostraMsg)
						EscrevaEAguarde("Conta inexistente!",TEMPO_PADRAO)
					retorne falso
				}
			}
		}
		retorne falso
	}

	funcao logico validaAcesso(cadeia pLogin, cadeia pSenha, cadeia pConta)
	{
		se (t.numero_caracteres(pConta) == TAMANHO_PADRAO)
		{
			se (nao (ExisteConta(pConta,verdadeiro)))
				retorne falso
		}
		senao
			retorne falso
		retorne (pLogin == LOGIN_CORRETO) e (pSenha == SENHA_CORRETA)
	}

	funcao logico ExisteSaldo(cadeia pConta, real pValor)
	{
		se ( SaldoContaA < pValor )
		{
			EscrevaEAguarde(MSG_SEM_SALDO,TEMPO_PADRAO)
			retorne falso
		}
		retorne verdadeiro
	}

	funcao EscrevaEAguarde(cadeia pMensagem, inteiro pTempo)
	{
		escreva(pMensagem)
		u.aguarde(pTempo)		
	}

	funcao VerSaldo()
	{
		EscrevaEAguarde(("Saldo atual: "+ m.arredondar(SaldoContaA, 3)),TEMPO_PADRAO)
		escreva("\n",u.tempo_decorrido())
		u.aguarde(1000)
	}

	funcao mostraMenu()
	{
		enquanto ( opcao != 5 )
		{
			limpa()
			escreva("+----------------------------------+\n")
			escreva("|           BANCO PROWAY           |\n")
			escreva("+----------------------------------+\n")
			escreva("| 1- Sacar        2- Depositar     |\n")
			escreva("| 3- Transferir   4- Ver Saldo     |\n")
			escreva("| 5- Sair         6- Configuracao  |\n")
			escreva("+----------------------------------+\n")
			leia( opcao )
			escolha ( opcao )
			{
				caso 1:
				{
					escreva("Valor do Saque: ")
					leia( valor )
					se ( ExisteSaldo(conta, valor) )
					{
						SaldoContaA -= valor
						EscrevaEAguarde("Saque efetuado com sucesso!",TEMPO_PADRAO)
					}
					pare
				}
				caso 2:
				{
					escreva("Valor do Depósito: ")
					leia( valor )
					SaldoContaA += valor
					EscrevaEAguarde("Depósito efetuado com sucesso!",TEMPO_PADRAO)
					pare
				}
				caso 3:
				{
					escreva("Conta Destino: ")
					leia(contaDestino)
					se (ExisteConta(contaDestino,verdadeiro))
					{
						escreva("Valor para transferência: ")
						leia( valor )
						se (ExisteSaldo(conta, valor))
						{
							SaldoContaA -= valor
							SaldoContaB += valor
							EscrevaEAguarde("Transferência efetuada com sucesso",TEMPO_PADRAO)
						}
					}
					pare
				}
				caso 4:
				{
					VerSaldo()
					pare
				}
				caso 5:
				{
					pare
				}
				caso 6:
				{
					escreva("Quantos segundos a mensagem deve ficar na tela? ")
					leia(tempo)
					Configuracao(tempo)
					pare
				}
				caso contrario:
					EscrevaEAguarde("Opção inválida",TEMPO_PADRAO)
			}
		}
		escreva(mensagemFinal)
	}
	
	funcao inicio()
	{
		enquanto (nao (validaAcesso(login,senha,conta)))
		{
			se ((login != "") e (senha != "") e (conta != "")) 
			{
				se (ExisteConta(conta,falso))
				{
					escreva("Login/Senha inválidos")
					u.aguarde(3000)					
				}
			}
			limpa()
			escreva("Login: ")
			leia(login)
			escreva("Senha: ")
			leia(senha)
			escreva("Número da Conta: ")
			leia(conta)
			
		}
		escreva("Acesso realizado com sucesso!")
		u.aguarde(3000)
		limpa()
		mostraMenu()
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1024; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {TEMPO_PADRAO, 13, 9, 12};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */