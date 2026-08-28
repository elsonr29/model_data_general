# DADOS DA CVM E B3
# 
# RESUMO
# Apresenta o roteiro direto para baixar os dados públicos da Comissão de Valores 
# Mobiliários (CVM) referentes às companhias de capital aberto negociadas na B3.
#
#-------------------------------------------------------------------------------
# AUTOR: Prof. Dr. Elson Rodrigo de Souza Santos
# E-MAIL: [elson129@gmail.com] ou [elson.rodrigo@ufabc.edu.br]
# REPOSITÓRIO: https://github.com/elson29r/model_data_general
# DATA: Agosto de 2026
#
################################################################################
# SUMÁRIO
#
# 1 Instalação e carregamento dos pacotes
# 2 Teste: Petrobras; Vale; Banco do Brasil
# 3 Base completa
#
################################################################################
# 1 Instação e carregamento dos pacotes
#
# Instalação 

install.packages("GetDFPData2")

# Pacotes complementares 

install.packages("readr", type = "source")
install.packages("timechange", type = "source")
install.packages("janitor", type = "source")

# Obs.: a instalação dessas dependências a partir do código-fonte resolve 
# eventuais falhas de compilação do pacote principal 'GetDFPData2'.

# Carregar

library(GetDFPData2)

#
# Obs.: usamos o pacote Reading Annual and Quarterly Financial Reports from B3
#
################################################################################
# 2 Teste: Petrobras; Vale; Banco do Brasil
#
# Usamos três empresas de capital aberto, grandes, sólidas e tradicionais para
# testar o script de importação de dados 
#
#-------------------------------------------------------------------------------
# Passo a passo:
# 1 Cronologia
# 2 Informação para dataframe
# 3 Teste: Petrobras; Vale; e Banco do Brasil
# 4 Exportar
#
#-------------------------------------------------------------------------------
# 1 Cronologia

ano_inicial = 2016
ano_final = 2026
 
# Definimos o ano inicial e final da base de dados
#
#-------------------------------------------------------------------------------
# 2 Informação para dataframe

info_empresas = get_info_companies()

# O pacote possui uma funcao nativa para buscar os nomes oficiais. Isso cria um
# dataframe com todas as firmas registradas.
#
# Lista de infomações das empresas

names(info_empresas)

# Filtrar apenas as empresas com registro ativo na CVM

empresas_ativas = subset(info_empresas, SIT_REG == "ATIVO")
lista_nomes = empresas_ativas$DENOM_SOCIAL

# Filtramos as empresas ativas
#
#-------------------------------------------------------------------------------
# 3 Teste: Petrobras; Vale; e Banco do Brasil

nomes_teste = c("PETROLEO BRASILEIRO S.A. PETROBRAS", 
                "VALE S.A.", 
                "BANCO DO BRASIL S.A."
                )

# Selecionamos as três empresas testes
#
# Filtragem

tabela_filtrada = subset(info_empresas, DENOM_SOCIAL %in% nomes_teste)
codigos_cvm = tabela_filtrada$CD_CVM

# Coleta dos dados
dados_cvm = get_dfp_data(
  companies_cvm_codes = codigos_cvm, 
  first_year = ano_inicial,
  last_year = ano_final,
  type_docs = c("BPA", "BPP", "DRE"), 
  type_format = "con", 
  clean_data = TRUE,
  use_memo = TRUE 
)

# Visualizar a estrutura inicial do painel gerado

head(dados_cvm)

#
#-------------------------------------------------------------------------------
# 4 Exportar
#
# Verificar nomes

names(dados_cvm)

# Exportar para arquivos CSV
#
# Loop para salvar todas as tabelas presentes na lista

for (nome_tabela in names(dados_cvm)) {
  nome_arquivo = paste0(gsub("[^[:alnum:]]", "_", nome_tabela), ".csv")
  write.csv(dados_cvm[[nome_tabela]], file = nome_arquivo, row.names = FALSE)
}

#
#-------------------------------------------------------------------------------
# 3 Base completa
#
# Apresentamos o código-base para extrair os dados das companias ativas na CVM 
# e B3
# -
#-------------------------------------------------------------------------------
# Passo a passo:
# 1 Cronologia
# 2 Informação para dataframe
# 3 Extração de dados
# 4 Exportar
#
#-------------------------------------------------------------------------------
# 1 Cronologia

ano_inicial = 2016
ano_final = 2026

# Definimos o ano inicial e final da base de dados
#
#-------------------------------------------------------------------------------
# 2 Informação para dataframe

codigos_cvm_completos = empresas_ativas$CD_CVM

#-------------------------------------------------------------------------------
# 3 Extração de dados

dados_cvm_completos = get_dfp_data(
  companies_cvm_codes = codigos_cvm_completos, 
  first_year = ano_inicial,
  last_year = ano_final,
  type_docs = c("BPA", "BPP", "DRE"), 
  type_format = "con", 
  clean_data = TRUE,
  use_memo = TRUE 
)

#
# Visualização

dim(dados_cvm_completos[[1]])

#
#-------------------------------------------------------------------------------
# 4 Exportar
#
# Salva os arquivos CSV completos diretamente na pasta de dados brutos.

# Criar a estrutura de pastas no diretório

dir.create("data", showWarnings = FALSE)
dir.create("data/raw", showWarnings = FALSE)

# Loop para salvar todas as tabelas

for (nome_tabela in names(dados_cvm_completos)) {
  nome_arquivo = paste0("data/raw/base_completa_", gsub("[^[:alnum:]]", "_", nome_tabela), ".csv")
  write.csv(dados_cvm_completos[[nome_tabela]], file = nome_arquivo, row.names = FALSE)
}

#
################################################################################
# FIM
