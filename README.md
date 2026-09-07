# model_data_general
Reprodução de modelos, extração e compilação de dados macro, micro, governo e finanças em geral.

Sumário:

- data_cvm_anual_tri.ipynb (agosto/2026)- roteiro para extrair, compilar e exportar os dados das companhias ativas disponibilizadas pela CVM a partir do pacote Pandas. Contém os dados trimestrais e anuais entre 2011 e 2025;
- data_firmas_cvm.R (agosto/2026) - roteiro para extrair, compilar e exportar os dados das companhias ativas na CVM por meio do pacote GetDFPData2;
- data_stn_estados.ipynb (agosto/2026) - Apresenta o roteiro direto para baixar os dados públicos do Tesouro Transparente e do SICONFI para os estados brasileiros entre 2013 e 2025. Os dados são brutos, em valores nominais, conforme disponibilizados pelo SICONFI;
- data_stn_estados_filtro_basedca.ipynb (setembro/2026) - O script apresenta o roteiro para a extração e a filtragem de dados obtidos por meio da API do SICONFI, mantida pelo Tesouro Nacional, referentes aos estados brasileiros entre 2013 e 2025. O objetivo consiste em identificar as variáveis de interesse na Declaração de Contas Anuais (DCA) e exportar os resultados para um novo documento CSV. Essa abordagem evita o custo computacional atrelado ao uso de planilhas eletrônicas (principalmente Calc e Excel) e viabiliza uma alternativa mais leve e direta, recomendada para dataframes de grandes dimensões.
