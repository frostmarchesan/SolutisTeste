O desafio consiste em criar um app de banco, que consiste em uma tela de login e uma tela de extrato.

![Image Login](https://gitlab.solutis.digital/caique.silveira/desafio-ios/raw/cab728b84d89b645af23f87c424f0bf8554ffa55/Assets%20Teste%20Solutis/Login_Screen.png)

Na primeira tela teremos um formulario de login, o campo user deve aceitar email ou cpf, o campo password deve validar se a senha tem pelo menos um caracter especial e um caracter alfanumérico. Apos a validação, realizar o login no endpoint https://api.mobile.test.solutis.xyz/login e exibir os dados de retorno na próxima tela. O ultimo usuário logado deve ser salvo de forma segura localmente, e exibido na tela de login se houver algum salvo.

Na segunda tela será exibido os dados formatados do retorno do login e será necessário fazer um segundo request para obter os lançamentos do usuário, no endpoint https://api.mobile.test.solutis.xyz/extrato que retornará uma lista de lançamentos

![Image Menu](https://gitlab.solutis.digital/caique.silveira/desafio-ios/raw/cab728b84d89b645af23f87c424f0bf8554ffa55/Assets%20Teste%20Solutis/Home_populed.png)

O layout e assets se encontram em anexo neste repositório e a documentação da API encontra-se no arquivo "Teste da Solutis.postman_collection.json"

Para realização deste desafio você deve clonar este repositório e disponibilizar a resposta num repositório público no github.

A codificação deve ser feita utilizando as melhores práticas, recomenda-se a utilização de bibliotecas apropriadas e de amplo uso. 

O app será compilado e testado por nossa equipe para sua avaliação. O App será avaliado pela legibilidade de código, arquitetura utilizada e layout.

Deve ser usada a linguagem Swift, suporte a IOS 9 ou superior
