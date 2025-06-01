// E:/estudos/projetosflutter/adc/Projeto-Integrador-5SM-/lib/src/domain/models/car_model.dart
import 'package:flutter/material.dart';

// 1. Pneus
class Pneus {
  double pressaoUtilizada;
  bool pressaoOk;
  bool bolhasCortesOk;
  String outroDescricao;
  int kmRodados;
  DateTime dataUltimoCadastro;

  Pneus({
    required this.pressaoUtilizada,
    required this.pressaoOk,
    required this.bolhasCortesOk,
    this.outroDescricao = '',
    required this.kmRodados,
    required this.dataUltimoCadastro,
  });

  bool precisaTrocar() {
    final agora = DateTime.now();
    final cincoAnosAtras = DateTime(agora.year - 5, agora.month, agora.day);
    return kmRodados >= 50000 || dataUltimoCadastro.isBefore(cincoAnosAtras);
  }
}

// 2. Freios
class Freios {
  bool nivelFluidoOk;
  bool pastilhasOk;
  bool discosOk;
  bool fluidoOk;
  int kmRodadosPastilhas;
  int kmRodadosDiscos;
  DateTime dataUltimoCadastroFluido;

  Freios({
    required this.nivelFluidoOk,
    required this.pastilhasOk,
    required this.discosOk,
    required this.fluidoOk,
    required this.kmRodadosPastilhas,
    required this.kmRodadosDiscos,
    required this.dataUltimoCadastroFluido,
  });

  bool precisaTrocarPastilhas() => kmRodadosPastilhas >= 20000 && !pastilhasOk;

  bool precisaTrocarDiscos() => kmRodadosDiscos >= 40000 && !discosOk;

  bool precisaTrocarFluido() {
    final agora = DateTime.now();
    final doisAnosAtras = DateTime(agora.year - 2, agora.month, agora.day);
    return dataUltimoCadastroFluido.isBefore(doisAnosAtras) || !fluidoOk;
  }
}

// 3. Fluidos
class Fluidos {
  double nivelOleoMotor;
  bool oleoMotorOk;
  bool aditivoRadiadorOk;
  bool fluidoDirecaoHidraulicaOk;
  bool fluidoTransmissaoOk;
  bool fluidoLimpadorParaBrisaOk;
  int kmRodadosOleo;
  DateTime dataUltimoCadastroOleo;

  Fluidos({
    required this.nivelOleoMotor,
    required this.oleoMotorOk,
    required this.aditivoRadiadorOk,
    required this.fluidoDirecaoHidraulicaOk,
    required this.fluidoTransmissaoOk,
    required this.fluidoLimpadorParaBrisaOk,
    required this.kmRodadosOleo,
    required this.dataUltimoCadastroOleo,
  });

  bool precisaTrocarOleo() {
    final agora = DateTime.now();
    final umAnoAtras = DateTime(agora.year - 1, agora.month, agora.day);
    return kmRodadosOleo >= 10000 ||
        dataUltimoCadastroOleo.isBefore(umAnoAtras) ||
        !oleoMotorOk;
  }
}

// 4. Bateria
class Bateria {
  bool terminaisCorrosao;
  int idadeAnos;
  bool testeNaOficina;

  Bateria({
    required this.terminaisCorrosao,
    required this.idadeAnos,
    required this.testeNaOficina,
  });

  bool precisaTrocar() {
    return idadeAnos >= 3 || terminaisCorrosao || !testeNaOficina;
  }
}

// 5. Sistema de Iluminação
class SistemaIluminacao {
  bool farolAltoOk;
  bool farolBaixoOk;
  bool lanternasOk;
  bool luzFreioOk;
  bool luzReOk;
  bool piscasOk;
  bool luzPlacaOk;

  SistemaIluminacao({
    required this.farolAltoOk,
    required this.farolBaixoOk,
    required this.lanternasOk,
    required this.luzFreioOk,
    required this.luzReOk,
    required this.piscasOk,
    required this.luzPlacaOk,
  });

  bool precisaTrocar() {
    return !(farolAltoOk &&
        farolBaixoOk &&
        lanternasOk &&
        luzFreioOk &&
        luzReOk &&
        piscasOk &&
        luzPlacaOk);
  }
}

// 6. Palhetas do Limpador de Para-brisa
class PalhetasLimpador {
  bool estadoOk;
  DateTime dataUltimoCadastro;

  PalhetasLimpador({
    required this.estadoOk,
    required this.dataUltimoCadastro,
  });

  bool precisaTrocar() {
    final agora = DateTime.now();
    final umAnoAtras = DateTime(agora.year - 1, agora.month, agora.day);
    return !estadoOk || dataUltimoCadastro.isBefore(umAnoAtras);
  }
}

// 7. Correias (Dentada/Alternador/AC)
class Correias {
  bool correiaDentadaOk;
  bool correiaAlternadorOk;
  int kmRodadosCorreiaDentada;
  int kmRodadosCorreiaAlternador;
  DateTime dataUltimoCadastroCorreiaDentada;

  Correias({
    required this.correiaDentadaOk,
    required this.correiaAlternadorOk,
    required this.kmRodadosCorreiaDentada,
    required this.kmRodadosCorreiaAlternador,
    required this.dataUltimoCadastroCorreiaDentada,
  });

  bool precisaTrocarCorreiaDentada() {
    final agora = DateTime.now();
    final cincoAnosAtras = DateTime(agora.year - 5, agora.month, agora.day);
    return kmRodadosCorreiaDentada >= 50000 ||
        dataUltimoCadastroCorreiaDentada.isBefore(cincoAnosAtras) ||
        !correiaDentadaOk;
  }

  bool precisaTrocarCorreiaAlternador() {
    return kmRodadosCorreiaAlternador >= 60000 || !correiaAlternadorOk;
  }
}

// 8. Amortecedores e Suspensão
class AmortecedoresSuspensao {
  bool vazamentoAmortecedores;
  bool balancoExcessivo;
  bool ruidoSuspensao;
  int kmRodadosAmortecedores;

  AmortecedoresSuspensao({
    required this.vazamentoAmortecedores,
    required this.balancoExcessivo,
    required this.ruidoSuspensao,
    required this.kmRodadosAmortecedores,
  });

  bool precisaTrocar() {
    return kmRodadosAmortecedores >= 40000 ||
        vazamentoAmortecedores ||
        balancoExcessivo ||
        ruidoSuspensao;
  }
}

// 9. Filtros
class Filtros {
  bool filtroArMotorOk;
  bool filtroCombustivelOk;
  bool filtroArCondicionadoOk;
  int kmRodadosFiltroArMotor;
  int kmRodadosFiltroCombustivel;
  int kmRodadosFiltroArCondicionado;

  Filtros({
    required this.filtroArMotorOk,
    required this.filtroCombustivelOk,
    required this.filtroArCondicionadoOk,
    required this.kmRodadosFiltroArMotor,
    required this.kmRodadosFiltroCombustivel,
    required this.kmRodadosFiltroArCondicionado,
  });

  bool precisaTrocarFiltroArMotor() =>
      kmRodadosFiltroArMotor >= 10000 || !filtroArMotorOk;

  bool precisaTrocarFiltroCombustivel() =>
      kmRodadosFiltroCombustivel >= 20000 || !filtroCombustivelOk;

  bool precisaTrocarFiltroArCondicionado() =>
      kmRodadosFiltroArCondicionado >= 10000 || !filtroArCondicionadoOk;
}

// 10. Velas de Ignição
class VelasIgnicao {
  bool estadoOk;
  int kmRodados;
  DateTime dataUltimoCadastro;

  VelasIgnicao({
    required this.estadoOk,
    required this.kmRodados,
    required this.dataUltimoCadastro,
  });

  bool precisaTrocar() {
    final agora = DateTime.now();
    final cincoAnosAtras = DateTime(agora.year - 5, agora.month, agora.day);
    return kmRodados >= 40000 ||
        dataUltimoCadastro.isBefore(cincoAnosAtras) ||
        !estadoOk;
  }
}

// 11. Sistema de Escapamento
class SistemaEscapamento {
  bool furos;
  bool rachaduras;
  bool componentesSoltos;

  SistemaEscapamento({
    required this.furos,
    required this.rachaduras,
    required this.componentesSoltos,
  });

  bool precisaTrocar() {
    return furos || rachaduras || componentesSoltos;
  }
}

// 12. Itens de Segurança e Documentação
class ItensSegurancaDocumentacao {
  bool extintorValido;
  bool trianguloOk;
  bool chaveDeRodaOk;
  bool macacoOk;
  bool kitPrimeirosSocorrosOk;
  bool documentosValidos;

  ItensSegurancaDocumentacao({
    required this.extintorValido,
    required this.trianguloOk,
    required this.chaveDeRodaOk,
    required this.macacoOk,
    required this.kitPrimeirosSocorrosOk,
    required this.documentosValidos,
  });

  bool precisaAtualizarDocumentos() => !documentosValidos;

  bool precisaReporExtintor() => !extintorValido;

  bool precisaCompletarKit() {
    return !(trianguloOk &&
        chaveDeRodaOk &&
        macacoOk &&
        kitPrimeirosSocorrosOk);
  }
}

class CarModel {
  Pneus pneus;
  Freios freios;
  Fluidos fluidos;
  Bateria bateria;
  SistemaIluminacao iluminacao;
  PalhetasLimpador palhetas;
  Correias correias;
  AmortecedoresSuspensao amortecedores;
  Filtros filtros;
  VelasIgnicao velas;
  SistemaEscapamento escapamento;
  ItensSegurancaDocumentacao seguranca;

  CarModel({
    required this.pneus,
    required this.freios,
    required this.fluidos,
    required this.bateria,
    required this.iluminacao,
    required this.palhetas,
    required this.correias,
    required this.amortecedores,
    required this.filtros,
    required this.velas,
    required this.escapamento,
    required this.seguranca,
  });

  // Método para obter um resumo completo de todos os dados
  Map<String, dynamic> getFullSummary() {
    return {
      'Pneus': {
        'Pressão Utilizada': '${pneus.pressaoUtilizada} PSI',
        'Pressão OK': pneus.pressaoOk ? 'Sim' : 'Não',
        'Sem Bolhas ou Cortes': pneus.bolhasCortesOk ? 'Sim' : 'Não',
        'KM Rodados': pneus.kmRodados,
        'Data Último Cadastro':
            '${pneus.dataUltimoCadastro.day}/${pneus.dataUltimoCadastro.month}/${pneus.dataUltimoCadastro.year}',
        'Precisa Trocar': pneus.precisaTrocar() ? 'Sim' : 'Não',
      },
      'Freios': {
        'Nível do Fluido OK': freios.nivelFluidoOk ? 'Sim' : 'Não',
        'Pastilhas OK': freios.pastilhasOk ? 'Sim' : 'Não',
        'Discos OK': freios.discosOk ? 'Sim' : 'Não',
        'Fluído OK': freios.fluidoOk ? 'Sim' : 'Não',
        'KM Rodados Pastilhas': freios.kmRodadosPastilhas,
        'KM Rodados Discos': freios.kmRodadosDiscos,
        'Data Último Cadastro Fluido':
            '${freios.dataUltimoCadastroFluido.day}/${freios.dataUltimoCadastroFluido.month}/${freios.dataUltimoCadastroFluido.year}',
        'Precisa Trocar Pastilhas':
            freios.precisaTrocarPastilhas() ? 'Sim' : 'Não',
        'Precisa Trocar Discos': freios.precisaTrocarDiscos() ? 'Sim' : 'Não',
        'Precisa Trocar Fluido': freios.precisaTrocarFluido() ? 'Sim' : 'Não',
      },
      'Fluidos': {
        'Nível Óleo Motor': fluidos.nivelOleoMotor,
        'Óleo Motor OK': fluidos.oleoMotorOk ? 'Sim' : 'Não',
        'Aditivo Radiador OK': fluidos.aditivoRadiadorOk ? 'Sim' : 'Não',
        'Fluído Direção Hidráulica OK':
            fluidos.fluidoDirecaoHidraulicaOk ? 'Sim' : 'Não',
        'Fluído Transmissão OK': fluidos.fluidoTransmissaoOk ? 'Sim' : 'Não',
        'Fluído Limpador para Brisa OK':
            fluidos.fluidoLimpadorParaBrisaOk ? 'Sim' : 'Não',
        'KM Rodados Óleo': fluidos.kmRodadosOleo,
        'Data Último Cadastro Óleo':
            '${fluidos.dataUltimoCadastroOleo.day}/${fluidos.dataUltimoCadastroOleo.month}/${fluidos.dataUltimoCadastroOleo.year}',
        'Precisa Trocar Óleo': fluidos.precisaTrocarOleo() ? 'Sim' : 'Não',
      },
      'Bateria': {
        'Terminais com Corrosão': bateria.terminaisCorrosao ? 'Sim' : 'Não',
        'Idade (anos)': bateria.idadeAnos,
        'Teste na Oficina OK': bateria.testeNaOficina ? 'Sim' : 'Não',
        'Precisa Trocar': bateria.precisaTrocar() ? 'Sim' : 'Não',
      },
      'Sistema de Iluminação': {
        'Farol Alto OK': iluminacao.farolAltoOk ? 'Sim' : 'Não',
        'Farol Baixo OK': iluminacao.farolBaixoOk ? 'Sim' : 'Não',
        'Lanternas OK': iluminacao.lanternasOk ? 'Sim' : 'Não',
        'Luz de Freio OK': iluminacao.luzFreioOk ? 'Sim' : 'Não',
        'Luz de Ré OK': iluminacao.luzReOk ? 'Sim' : 'Não',
        'Piscas OK': iluminacao.piscasOk ? 'Sim' : 'Não',
        'Luz da Placa OK': iluminacao.luzPlacaOk ? 'Sim' : 'Não',
        'Precisa Trocar': iluminacao.precisaTrocar() ? 'Sim' : 'Não',
      },
      'Palhetas do Limpador': {
        'Estado OK': palhetas.estadoOk ? 'Sim' : 'Não',
        'Data Último Cadastro':
            '${palhetas.dataUltimoCadastro.day}/${palhetas.dataUltimoCadastro.month}/${palhetas.dataUltimoCadastro.year}',
        'Precisa Trocar': palhetas.precisaTrocar() ? 'Sim' : 'Não',
      },
      'Correias': {
        'Correia Dentada OK': correias.correiaDentadaOk ? 'Sim' : 'Não',
        'Correia do Alternador OK':
            correias.correiaAlternadorOk ? 'Sim' : 'Não',
        'KM Rodados Correia Dentada': correias.kmRodadosCorreiaDentada,
        'KM Rodados Correia Alternador': correias.kmRodadosCorreiaAlternador,
        'Data Último Cadastro Correia Dentada':
            '${correias.dataUltimoCadastroCorreiaDentada.day}/${correias.dataUltimoCadastroCorreiaDentada.month}/${correias.dataUltimoCadastroCorreiaDentada.year}',
        'Precisa Trocar Correia Dentada':
            correias.precisaTrocarCorreiaDentada() ? 'Sim' : 'Não',
        'Precisa Trocar Correia Alternador':
            correias.precisaTrocarCorreiaAlternador() ? 'Sim' : 'Não',
      },
      'Amortecedores e Suspensão': {
        'Vazamento nos Amortecedores':
            amortecedores.vazamentoAmortecedores ? 'Sim' : 'Não',
        'Balanço Excessivo': amortecedores.balancoExcessivo ? 'Sim' : 'Não',
        'Ruído na Suspensão': amortecedores.ruidoSuspensao ? 'Sim' : 'Não',
        'KM Rodados Amortecedores': amortecedores.kmRodadosAmortecedores,
        'Precisa Trocar': amortecedores.precisaTrocar() ? 'Sim' : 'Não',
      },
      'Filtros': {
        'Filtro de Ar do Motor OK': filtros.filtroArMotorOk ? 'Sim' : 'Não',
        'Filtro de Combustível OK': filtros.filtroCombustivelOk ? 'Sim' : 'Não',
        'Filtro do Ar Condicionado OK':
            filtros.filtroArCondicionadoOk ? 'Sim' : 'Não',
        'KM Rodados Filtro Ar Motor': filtros.kmRodadosFiltroArMotor,
        'KM Rodados Filtro Combustível': filtros.kmRodadosFiltroCombustivel,
        'KM Rodados Filtro Ar Condicionado':
            filtros.kmRodadosFiltroArCondicionado,
        'Precisa Trocar Filtro Ar Motor':
            filtros.precisaTrocarFiltroArMotor() ? 'Sim' : 'Não',
        'Precisa Trocar Filtro Combustível':
            filtros.precisaTrocarFiltroCombustivel() ? 'Sim' : 'Não',
        'Precisa Trocar Filtro Ar Condicionado':
            filtros.precisaTrocarFiltroArCondicionado() ? 'Sim' : 'Não',
      },
      'Velas de Ignição': {
        'Estado OK': velas.estadoOk ? 'Sim' : 'Não',
        'KM Rodados': velas.kmRodados,
        'Data Último Cadastro':
            '${velas.dataUltimoCadastro.day}/${velas.dataUltimoCadastro.month}/${velas.dataUltimoCadastro.year}',
        'Precisa Trocar': velas.precisaTrocar() ? 'Sim' : 'Não',
      },
      'Sistema de Escapamento': {
        'Furos': escapamento.furos ? 'Sim' : 'Não',
        'Rachaduras': escapamento.rachaduras ? 'Sim' : 'Não',
        'Componentes Soltos': escapamento.componentesSoltos ? 'Sim' : 'Não',
        'Precisa Trocar': escapamento.precisaTrocar() ? 'Sim' : 'Não',
      },
      'Itens de Segurança e Documentação': {
        'Extintor Válido': seguranca.extintorValido ? 'Sim' : 'Não',
        'Triângulo OK': seguranca.trianguloOk ? 'Sim' : 'Não',
        'Chave de Roda OK': seguranca.chaveDeRodaOk ? 'Sim' : 'Não',
        'Macaco OK': seguranca.macacoOk ? 'Sim' : 'Não',
        'Kit Primeiros Socorros OK':
            seguranca.kitPrimeirosSocorrosOk ? 'Sim' : 'Não',
        'Documentos Válidos': seguranca.documentosValidos ? 'Sim' : 'Não',
        'Precisa Atualizar Documentos':
            seguranca.precisaAtualizarDocumentos() ? 'Sim' : 'Não',
        'Precisa Repor Extintor':
            seguranca.precisaReporExtintor() ? 'Sim' : 'Não',
        'Precisa Completar Kit':
            seguranca.precisaCompletarKit() ? 'Sim' : 'Não',
      },
    };
  }
}
