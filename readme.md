---
# Projeto AWS: Infraestrutura como Código (IaC) com Terraform

Neste projeto, a infraestrutura na AWS foi implementada utilizando a abordagem de Infraestrutura como Código (IaC) com o Terraform. A seguir, são detalhados os requisitos técnicos do projeto e fornecido um guia passo a passo para validar a infraestrutura.

## Infraestrutura Implementada

### 1. Infraestrutura como Código (IaC) com Terraform:

- Utilizou-se o Terraform para criar e gerenciar todos os recursos na AWS.
- Estruturou-se o código Terraform utilizando módulos para separar responsabilidades.
- Armazenou-se o estado do Terraform em um bucket S3 para o lock do estado.
- Implementaram-se scripts que criam e destroem a infraestrutura completa com um único comando.

### 2. Application Load Balancer (ALB):

- Provisionou-se um ALB para distribuir o tráfego entre as instâncias EC2.
- Configuraram-se Target Groups para gerenciar as instâncias EC2.
- Implementaram-se Health Checks para garantir que o tráfego seja direcionado apenas para instâncias saudáveis.

### 3. EC2 com Auto Scaling:

- Criou-se um Launch Configuration com uma AMI que possui a aplicação pré-instalada.
- Provisionou-se um Auto Scaling Group (ASG) utilizando o Launch Configuration criado.
- Definiram-se políticas de escalabilidade baseadas em CloudWatch Alarms para garantir alta disponibilidade.
- Garantiu-se a integração do ASG com o ALB através do Target Group.

### 4. Banco de Dados RDS:

- Provisionou-se uma instância RDS MySQL ou PostgreSQL com a configuração db.t2.micro.
- Habilitaram-se backups automáticos e definiu-se uma janela de manutenção.
- Configuraram-se Security Groups para restringir o acesso ao RDS somente a partir das instâncias EC2.
- Habilitou-se o Multi-AZ para garantir alta disponibilidade.

### 5. Aplicação:

- Implementou-se uma aplicação simples, seja uma API RESTful ou uma aplicação web.
- A aplicação é capaz de se conectar ao banco de dados RDS e realizar operações CRUD.
- Implementaram-se métricas e logs utilizando o CloudWatch.

### 6. Análise de Custo com a Calculadora AWS:

- Utilizou-se a Calculadora de Custo da AWS para estimar os custos mensais da arquitetura proposta.
- Consideraram-se os custos de todos os recursos utilizados (EC2, ALB, RDS, etc.).
- Elaborou-se um relatório detalhado com a previsão de custos, destacando os principais gastos e possíveis otimizações.

## Guia de Validação da Infraestrutura


0. **Credenciais AWS:**
    Recomenda-se o uso de arquivos CSV ou outras formas seguras de armazenamento. Abaixo está um exemplo de como um arquivo CSV pode ser estruturado:

   - **profile_acessKeys.csv:**
     ```csv
     Access key ID,Secret access key
     ??????????????,??????????????,
     ```

   - **profile_credentials.csv:**
     ```csv
     Nome do usuário,Senha,URL de login do console
     ??????????????,,??????????????,,https://compnuvem06.signin.aws.amazon.com/console
     ```


1. **Configuração Inicial:**
   Certifique-se de ter o Terraform instalado localmente e configurado com as credenciais da AWS.

   ```bash
   terraform init
   ```

2. **Criação da Infraestrutura:**
   Execute o seguinte comando para criar a infraestrutura na AWS:

   ```bash
   terraform apply
   ```

   O Terraform solicitará confirmação para aplicar as alterações. Digite `yes` quando solicitado.

3. **Validação da Infraestrutura:**
   Após a conclusão, verifique a saída do Terraform para obter informações sobre os recursos criados.

4. **Destruir a Infraestrutura (Opcional):**
   Se desejar destruir a infraestrutura criada, execute:

   ```bash
   terraform destroy
   ```

   Novamente, confirme digitando `yes` quando solicitado.

5. **Análise de Custo:**
   Para obter detalhes adicionais e um relatório detalhado, consulte o arquivo [My Estimate - Calculadora de Preços da AWS.pdf](CAMINHO_COMPLETO_DO_ARQUIVO).


---
