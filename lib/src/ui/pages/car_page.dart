import 'package:adc/src/domain/models/car_model.dart';
import 'package:adc/src/ui/_core/widgets/my_appbar.dart';
import 'package:adc/src/ui/_core/widgets/my_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarPage extends StatefulWidget {
  const CarPage({super.key});
  @override
  State<CarPage> createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
  static const _routes = ['/', '/car', '/help', '/profile', '/settings'];
  int getCurrentIndex(BuildContext context) {
    final location =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final index = _routes.indexOf(location);
    return index < 0 ? 0 : index;
  }

  // Instâncias para armazenar os dados preenchidos (inicialmente com valores padrão)
  Pneus pneus = Pneus(
    pressaoUtilizada: 32,
    pressaoOk: true,
    bolhasCortesOk: true,
    kmRodados: 0,
    dataUltimoCadastro: DateTime.now(),
  );
  Freios freios = Freios(
    nivelFluidoOk: true,
    pastilhasOk: true,
    discosOk: true,
    fluidoOk: true,
    kmRodadosPastilhas: 0,
    kmRodadosDiscos: 0,
    dataUltimoCadastroFluido: DateTime.now(),
  );
  Fluidos fluidos = Fluidos(
    nivelOleoMotor: 1.0,
    oleoMotorOk: true,
    aditivoRadiadorOk: true,
    fluidoDirecaoHidraulicaOk: true,
    fluidoTransmissaoOk: true,
    fluidoLimpadorParaBrisaOk: true,
    kmRodadosOleo: 0,
    dataUltimoCadastroOleo: DateTime.now(),
  );
  Bateria bateria = Bateria(
    terminaisCorrosao: false,
    idadeAnos: 0,
    testeNaOficina: false,
  );
  SistemaIluminacao iluminacao = SistemaIluminacao(
    farolAltoOk: true,
    farolBaixoOk: true,
    lanternasOk: true,
    luzFreioOk: true,
    luzReOk: true,
    piscasOk: true,
    luzPlacaOk: true,
  );
  PalhetasLimpador palhetas = PalhetasLimpador(
    estadoOk: true,
    dataUltimoCadastro: DateTime.now(),
  );
  Correias correias = Correias(
    correiaDentadaOk: true,
    correiaAlternadorOk: true,
    kmRodadosCorreiaDentada: 0,
    kmRodadosCorreiaAlternador: 0,
    dataUltimoCadastroCorreiaDentada: DateTime.now(),
  );
  AmortecedoresSuspensao amortecedores = AmortecedoresSuspensao(
    vazamentoAmortecedores: false,
    balancoExcessivo: false,
    ruidoSuspensao: false,
    kmRodadosAmortecedores: 0,
  );
  Filtros filtros = Filtros(
    filtroArMotorOk: true,
    filtroCombustivelOk: true,
    filtroArCondicionadoOk: true,
    kmRodadosFiltroArMotor: 0,
    kmRodadosFiltroCombustivel: 0,
    kmRodadosFiltroArCondicionado: 0,
  );
  VelasIgnicao velas = VelasIgnicao(
    estadoOk: true,
    kmRodados: 0,
    dataUltimoCadastro: DateTime.now(),
  );
  SistemaEscapamento escapamento = SistemaEscapamento(
    furos: false,
    rachaduras: false,
    componentesSoltos: false,
  );
  ItensSegurancaDocumentacao seguranca = ItensSegurancaDocumentacao(
    extintorValido: true,
    trianguloOk: true,
    chaveDeRodaOk: true,
    macacoOk: true,
    kitPrimeirosSocorrosOk: true,
    documentosValidos: true,
  );
  // Para controlar a página/aba atual (pode ser expandido para usar abas)
  int currentSection = 0;
  // Lista dos títulos para facilitar navegação
  final List<String> sectionTitles = [
    'Pneus',
    'Freios',
    'Fluidos',
    'Bateria',
    'Sistema de Iluminação',
    'Palhetas do Limpador',
    'Correias',
    'Amortecedores e Suspensão',
    'Filtros',
    'Velas de Ignição',
    'Sistema de Escapamento',
    'Itens de Segurança e Documentação',
    'Resumo Completo', // Add the new summary section title
  ];
  // Navegar entre seções
  void _nextSection() {
    setState(() {
      if (currentSection < sectionTitles.length - 1) {
        currentSection++;
      } else {
        // Se estiver na última seção (Resumo Completo),
        // adicione a lógica para "Concluir" aqui.
        // Por exemplo, exibir um SnackBar ou navegar para uma tela de sucesso.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dados do veículo salvos com sucesso!'),
            duration: Duration(seconds: 2),
          ),
        );
        // Opcional: Navegar para outra rota após a conclusão
        // GoRouter.of(context).go('/home');
      }
    });
  }

  void _prevSection() {
    setState(() {
      if (currentSection > 0) currentSection--;
    });
  }

  // Widget genérico para checkbox booleano
  Widget _buildCheckbox(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      title: Text(label, style: const TextStyle(color: Colors.white)),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.lightBlueAccent,
      checkColor: Colors.black,
    );
  }

  // Widget genérico para double input
  Widget _buildDoubleInput(
      String label, double value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          border: const OutlineInputBorder(),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent)),
        ),
        controller: TextEditingController(text: value.toString()),
        onChanged: onChanged,
      ),
    );
  }

  // Widget genérico para int input
  Widget _buildIntInput(
      String label, int value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          border: const OutlineInputBorder(),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent)),
        ),
        controller: TextEditingController(text: value.toString()),
        onChanged: onChanged,
      ),
    );
  }

  // Widget genérico para Date input (apenas exibe data e abre seletor)
  Widget _buildDateInput(
      String label, DateTime date, ValueChanged<DateTime> onDateSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(label, style: const TextStyle(color: Colors.white70)),
        subtitle: Text('${date.day}/${date.month}/${date.year}',
            style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.calendar_today, color: Colors.white70),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: date,
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (picked != null) onDateSelected(picked);
        },
      ),
    );
  }

  // Widget para mostrar dados da seção atual com formulário simples
  Widget _buildSectionForm() {
    switch (currentSection) {
      case 0: // Pneus
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoubleInput('Pressão Utilizada (PSI)', pneus.pressaoUtilizada,
                (v) {
              final val = double.tryParse(v);
              if (val != null) setState(() => pneus.pressaoUtilizada = val);
            }),
            _buildCheckbox('Pressão OK', pneus.pressaoOk, (v) {
              if (v != null) setState(() => pneus.pressaoOk = v);
            }),
            _buildCheckbox('Sem Bolhas ou Cortes', pneus.bolhasCortesOk, (v) {
              if (v != null) setState(() => pneus.bolhasCortesOk = v);
            }),
            _buildIntInput('KM Rodados (Pneu)', pneus.kmRodados, (v) {
              final val = int.tryParse(v);
              if (val != null) setState(() => pneus.kmRodados = val);
            }),
            _buildDateInput('Data Último Cadastro', pneus.dataUltimoCadastro,
                (d) {
              setState(() => pneus.dataUltimoCadastro = d);
            }),
          ],
        );
      case 1: // Freios
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Nível do Fluido OK', freios.nivelFluidoOk, (v) {
              if (v != null) setState(() => freios.nivelFluidoOk = v);
            }),
            _buildCheckbox('Pastilhas OK', freios.pastilhasOk, (v) {
              if (v != null) setState(() => freios.pastilhasOk = v);
            }),
            _buildCheckbox('Discos OK', freios.discosOk, (v) {
              if (v != null) setState(() => freios.discosOk = v);
            }),
            _buildCheckbox('Fluído OK', freios.fluidoOk, (v) {
              if (v != null) setState(() => freios.fluidoOk = v);
            }),
            _buildIntInput('KM Rodados Pastilhas', freios.kmRodadosPastilhas,
                (v) {
              final val = int.tryParse(v);
              if (val != null) setState(() => freios.kmRodadosPastilhas = val);
            }),
            _buildIntInput('KM Rodados Discos', freios.kmRodadosDiscos, (v) {
              final val = int.tryParse(v);
              if (val != null) setState(() => freios.kmRodadosDiscos = val);
            }),
            _buildDateInput(
                'Data Último Cadastro Fluido', freios.dataUltimoCadastroFluido,
                (d) {
              setState(() => freios.dataUltimoCadastroFluido = d);
            }),
          ],
        );
      case 2: // Fluidos
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoubleInput('Nível Óleo Motor', fluidos.nivelOleoMotor, (v) {
              final val = double.tryParse(v);
              if (val != null) setState(() => fluidos.nivelOleoMotor = val);
            }),
            _buildCheckbox('Óleo Motor OK', fluidos.oleoMotorOk, (v) {
              if (v != null) setState(() => fluidos.oleoMotorOk = v);
            }),
            _buildCheckbox('Aditivo Radiador OK', fluidos.aditivoRadiadorOk,
                (v) {
              if (v != null) setState(() => fluidos.aditivoRadiadorOk = v);
            }),
            _buildCheckbox('Fluído Direção Hidráulica OK',
                fluidos.fluidoDirecaoHidraulicaOk, (v) {
              if (v != null)
                setState(() => fluidos.fluidoDirecaoHidraulicaOk = v);
            }),
            _buildCheckbox('Fluído Transmissão OK', fluidos.fluidoTransmissaoOk,
                (v) {
              if (v != null) setState(() => fluidos.fluidoTransmissaoOk = v);
            }),
            _buildCheckbox('Fluído Limpador para Brisa OK',
                fluidos.fluidoLimpadorParaBrisaOk, (v) {
              if (v != null)
                setState(() => fluidos.fluidoLimpadorParaBrisaOk = v);
            }),
            _buildIntInput('KM Rodados Óleo', fluidos.kmRodadosOleo, (v) {
              final val = int.tryParse(v);
              if (val != null) setState(() => fluidos.kmRodadosOleo = val);
            }),
            _buildDateInput(
                'Data Último Cadastro Óleo', fluidos.dataUltimoCadastroOleo,
                (d) {
              setState(() => fluidos.dataUltimoCadastroOleo = d);
            }),
          ],
        );
      case 3: // Bateria
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Terminais com Corrosão', bateria.terminaisCorrosao,
                (v) {
              if (v != null) setState(() => bateria.terminaisCorrosao = v);
            }),
            _buildIntInput('Idade (anos)', bateria.idadeAnos, (v) {
              final val = int.tryParse(v);
              if (val != null) setState(() => bateria.idadeAnos = val);
            }),
            _buildCheckbox('Teste na Oficina OK', bateria.testeNaOficina, (v) {
              if (v != null) setState(() => bateria.testeNaOficina = v);
            }),
          ],
        );
      case 4: // Sistema de Iluminação
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Farol Alto OK', iluminacao.farolAltoOk, (v) {
              if (v != null) setState(() => iluminacao.farolAltoOk = v);
            }),
            _buildCheckbox('Farol Baixo OK', iluminacao.farolBaixoOk, (v) {
              if (v != null) setState(() => iluminacao.farolBaixoOk = v);
            }),
            _buildCheckbox('Lanternas OK', iluminacao.lanternasOk, (v) {
              if (v != null) setState(() => iluminacao.lanternasOk = v);
            }),
            _buildCheckbox('Luz de Freio OK', iluminacao.luzFreioOk, (v) {
              if (v != null) setState(() => iluminacao.luzFreioOk = v);
            }),
            _buildCheckbox('Luz de Ré OK', iluminacao.luzReOk, (v) {
              if (v != null) setState(() => iluminacao.luzReOk = v);
            }),
            _buildCheckbox('Piscas OK', iluminacao.piscasOk, (v) {
              if (v != null) setState(() => iluminacao.piscasOk = v);
            }),
            _buildCheckbox('Luz da Placa OK', iluminacao.luzPlacaOk, (v) {
              if (v != null) setState(() => iluminacao.luzPlacaOk = v);
            }),
          ],
        );
      case 5: // Palhetas do Limpador
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Estado OK', palhetas.estadoOk, (v) {
              if (v != null) setState(() => palhetas.estadoOk = v);
            }),
            _buildDateInput('Data Último Cadastro', palhetas.dataUltimoCadastro,
                (d) {
              setState(() => palhetas.dataUltimoCadastro = d);
            }),
          ],
        );
      case 6: // Correias
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Correia Dentada OK', correias.correiaDentadaOk,
                (v) {
              if (v != null) setState(() => correias.correiaDentadaOk = v);
            }),
            _buildCheckbox(
                'Correia do Alternador OK', correias.correiaAlternadorOk, (v) {
              if (v != null) setState(() => correias.correiaAlternadorOk = v);
            }),
            _buildIntInput(
                'KM Rodados Correia Dentada', correias.kmRodadosCorreiaDentada,
                (v) {
              final val = int.tryParse(v);
              if (val != null)
                setState(() => correias.kmRodadosCorreiaDentada = val);
            }),
            _buildIntInput('KM Rodados Correia Alternador',
                correias.kmRodadosCorreiaAlternador, (v) {
              final val = int.tryParse(v);
              if (val != null)
                setState(() => correias.kmRodadosCorreiaAlternador = val);
            }),
            _buildDateInput('Data Último Cadastro Correia Dentada',
                correias.dataUltimoCadastroCorreiaDentada, (d) {
              setState(() => correias.dataUltimoCadastroCorreiaDentada = d);
            }),
          ],
        );
      case 7: // Amortecedores e Suspensão
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Vazamento nos Amortecedores',
                amortecedores.vazamentoAmortecedores, (v) {
              if (v != null)
                setState(() => amortecedores.vazamentoAmortecedores = v);
            }),
            _buildCheckbox('Balanço Excessivo', amortecedores.balancoExcessivo,
                (v) {
              if (v != null) setState(() => amortecedores.balancoExcessivo = v);
            }),
            _buildCheckbox('Ruído na Suspensão', amortecedores.ruidoSuspensao,
                (v) {
              if (v != null) setState(() => amortecedores.ruidoSuspensao = v);
            }),
            _buildIntInput('KM Rodados Amortecedores',
                amortecedores.kmRodadosAmortecedores, (v) {
              final val = int.tryParse(v);
              if (val != null)
                setState(() => amortecedores.kmRodadosAmortecedores = val);
            }),
          ],
        );
      case 8: // Filtros
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Filtro de Ar do Motor OK', filtros.filtroArMotorOk,
                (v) {
              if (v != null) setState(() => filtros.filtroArMotorOk = v);
            }),
            _buildCheckbox(
                'Filtro de Combustível OK', filtros.filtroCombustivelOk, (v) {
              if (v != null) setState(() => filtros.filtroCombustivelOk = v);
            }),
            _buildCheckbox(
                'Filtro do Ar Condicionado OK', filtros.filtroArCondicionadoOk,
                (v) {
              if (v != null) setState(() => filtros.filtroArCondicionadoOk = v);
            }),
            _buildIntInput(
                'KM Rodados Filtro Ar Motor', filtros.kmRodadosFiltroArMotor,
                (v) {
              final val = int.tryParse(v);
              if (val != null)
                setState(() => filtros.kmRodadosFiltroArMotor = val);
            }),
            _buildIntInput('KM Rodados Filtro Combustível',
                filtros.kmRodadosFiltroCombustivel, (v) {
              final val = int.tryParse(v);
              if (val != null)
                setState(() => filtros.kmRodadosFiltroCombustivel = val);
            }),
            _buildIntInput('KM Rodados Filtro Ar Condicionado',
                filtros.kmRodadosFiltroArCondicionado, (v) {
              final val = int.tryParse(v);
              if (val != null)
                setState(() => filtros.kmRodadosFiltroArCondicionado = val);
            }),
          ],
        );
      case 9: // Velas de Ignição
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Estado OK', velas.estadoOk, (v) {
              if (v != null) setState(() => velas.estadoOk = v);
            }),
            _buildIntInput('KM Rodados', velas.kmRodados, (v) {
              final val = int.tryParse(v);
              if (val != null) setState(() => velas.kmRodados = val);
            }),
            _buildDateInput('Data Último Cadastro', velas.dataUltimoCadastro,
                (d) {
              setState(() => velas.dataUltimoCadastro = d);
            }),
          ],
        );
      case 10: // Sistema de Escapamento
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Furos', escapamento.furos, (v) {
              if (v != null) setState(() => escapamento.furos = v);
            }),
            _buildCheckbox('Rachaduras', escapamento.rachaduras, (v) {
              if (v != null) setState(() => escapamento.rachaduras = v);
            }),
            _buildCheckbox('Componentes Soltos', escapamento.componentesSoltos,
                (v) {
              if (v != null) setState(() => escapamento.componentesSoltos = v);
            }),
          ],
        );
      case 11: // Itens de Segurança e Documentação
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckbox('Extintor Válido', seguranca.extintorValido, (v) {
              if (v != null) setState(() => seguranca.extintorValido = v);
            }),
            _buildCheckbox('Triângulo OK', seguranca.trianguloOk, (v) {
              if (v != null) setState(() => seguranca.trianguloOk = v);
            }),
            _buildCheckbox('Chave de Roda OK', seguranca.chaveDeRodaOk, (v) {
              if (v != null) setState(() => seguranca.chaveDeRodaOk = v);
            }),
            _buildCheckbox('Macaco OK', seguranca.macacoOk, (v) {
              if (v != null) setState(() => seguranca.macacoOk = v);
            }),
            _buildCheckbox(
                'Kit Primeiros Socorros OK', seguranca.kitPrimeirosSocorrosOk,
                (v) {
              if (v != null)
                setState(() => seguranca.kitPrimeirosSocorrosOk = v);
            }),
            _buildCheckbox('Documentos Válidos', seguranca.documentosValidos,
                (v) {
              if (v != null) setState(() => seguranca.documentosValidos = v);
            }),
          ],
        );
      case 12: // Full Summary (New Case)
        return _buildOverallSummary();
      default:
        return const Center(
            child:
                Text('Seção inválida', style: TextStyle(color: Colors.white)));
    }
  }

  // New method to build the overall summary
  Widget _buildOverallSummary() {
    final carModel = CarModel(
      pneus: pneus,
      freios: freios,
      fluidos: fluidos,
      bateria: bateria,
      iluminacao: iluminacao,
      palhetas: palhetas,
      correias: correias,
      amortecedores: amortecedores,
      filtros: filtros,
      velas: velas,
      escapamento: escapamento,
      seguranca: seguranca,
    );

    final fullSummary = carModel.getFullSummary();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resumo Detalhado do Veículo',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        ...fullSummary.keys.map((sectionTitle) {
          final sectionData = fullSummary[sectionTitle] as Map<String, dynamic>;
          return _buildSectionSummaryItem(
            sectionTitle,
            sectionData.entries.map((e) => '${e.key}: ${e.value}').join('\n'),
          );
        }).toList(),
      ],
    );
  }

  // Helper widget to display a summary item for each section
  Widget _buildSectionSummaryItem(String title, String content) {
    return Card(
      color: Colors.grey[850],
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // Visualização resumida da seção atual (pode melhorar para algo mais bonito)
  Widget _buildSectionSummary() {
    String text = '';
    switch (currentSection) {
      case 0:
        text =
            'Pneus:\nPressão: ${pneus.pressaoUtilizada} PSI\nPressão OK: ${pneus.pressaoOk}\nSem Bolhas/Cortes: ${pneus.bolhasCortesOk}\nKM Rodados: ${pneus.kmRodados}\nÚltimo Cadastro: ${pneus.dataUltimoCadastro.day}/${pneus.dataUltimoCadastro.month}/${pneus.dataUltimoCadastro.year}';
        break;
      case 1:
        text =
            'Freios:\nNível Fluido OK: ${freios.nivelFluidoOk}\nPastilhas OK: ${freios.pastilhasOk}\nDiscos OK: ${freios.discosOk}\nFluído OK: ${freios.fluidoOk}\nKM Rodados Pastilhas: ${freios.kmRodadosPastilhas}\nKM Rodados Discos: ${freios.kmRodadosDiscos}\nÚltimo Cadastro Fluido: ${freios.dataUltimoCadastroFluido.day}/${freios.dataUltimoCadastroFluido.month}/${freios.dataUltimoCadastroFluido.year}';
        break;
      case 2:
        text =
            'Fluidos:\nNível Óleo Motor: ${fluidos.nivelOleoMotor}\nÓleo Motor OK: ${fluidos.oleoMotorOk}\nAditivo Radiador OK: ${fluidos.aditivoRadiadorOk}\nFluído Direção Hidráulica OK: ${fluidos.fluidoDirecaoHidraulicaOk}\nFluído Transmissão OK: ${fluidos.fluidoTransmissaoOk}\nFluído Limpador para Brisa OK: ${fluidos.fluidoLimpadorParaBrisaOk}\nKM Rodados Óleo: ${fluidos.kmRodadosOleo}\nÚltimo Cadastro Óleo: ${fluidos.dataUltimoCadastroOleo.day}/${fluidos.dataUltimoCadastroOleo.month}/${fluidos.dataUltimoCadastroOleo.year}';
        break;
      case 3:
        text =
            'Bateria:\nTerminais com Corrosão: ${bateria.terminaisCorrosao}\nIdade (anos): ${bateria.idadeAnos}\nTeste na Oficina OK: ${bateria.testeNaOficina}';
        break;
      case 4:
        text =
            'Sistema de Iluminação:\nFarol Alto OK: ${iluminacao.farolAltoOk}\nFarol Baixo OK: ${iluminacao.farolBaixoOk}\nLanternas OK: ${iluminacao.lanternasOk}\nLuz de Freio OK: ${iluminacao.luzFreioOk}\nLuz de Ré OK: ${iluminacao.luzReOk}\nPiscas OK: ${iluminacao.piscasOk}\nLuz da Placa OK: ${iluminacao.luzPlacaOk}';
        break;
      case 5:
        text =
            'Palhetas do Limpador:\nEstado OK: ${palhetas.estadoOk}\nÚltimo Cadastro: ${palhetas.dataUltimoCadastro.day}/${palhetas.dataUltimoCadastro.month}/${palhetas.dataUltimoCadastro.year}';
        break;
      case 6:
        text =
            'Correias:\nCorreia Dentada OK: ${correias.correiaDentadaOk}\nCorreia do Alternador OK: ${correias.correiaAlternadorOk}\nKM Rodados Correia Dentada: ${correias.kmRodadosCorreiaDentada}\nKM Rodados Correia Alternador: ${correias.kmRodadosCorreiaAlternador}\nÚltimo Cadastro Correia Dentada: ${correias.dataUltimoCadastroCorreiaDentada.day}/${correias.dataUltimoCadastroCorreiaDentada.month}/${correias.dataUltimoCadastroCorreiaDentada.year}';
        break;
      case 7:
        text =
            'Amortecedores e Suspensão:\nVazamento nos Amortecedores: ${amortecedores.vazamentoAmortecedores}\nBalanço Excessivo: ${amortecedores.balancoExcessivo}\nRuído na Suspensão: ${amortecedores.ruidoSuspensao}\nKM Rodados Amortecedores: ${amortecedores.kmRodadosAmortecedores}';
        break;
      case 8:
        text =
            'Filtros:\nFiltro de Ar do Motor OK: ${filtros.filtroArMotorOk}\nFiltro de Combustível OK: ${filtros.filtroCombustivelOk}\nFiltro do Ar Condicionado OK: ${filtros.filtroArCondicionadoOk}\nKM Rodados Filtro Ar Motor: ${filtros.kmRodadosFiltroArMotor}\nKM Rodados Filtro Combustível: ${filtros.kmRodadosFiltroCombustivel}\nKM Rodados Filtro Ar Condicionado: ${filtros.kmRodadosFiltroArCondicionado}';
        break;
      case 9:
        text =
            'Velas de Ignição:\nEstado OK: ${velas.estadoOk}\nKM Rodados: ${velas.kmRodados}\nÚltimo Cadastro: ${velas.dataUltimoCadastro.day}/${velas.dataUltimoCadastro.month}/${velas.dataUltimoCadastro.year}';
        break;
      case 10:
        text =
            'Sistema de Escapamento:\nFuros: ${escapamento.furos}\nRachaduras: ${escapamento.rachaduras}\nComponentes Soltos: ${escapamento.componentesSoltos}';
        break;
      case 11:
        text =
            'Itens de Segurança e Documentação:\nExtintor Válido: ${seguranca.extintorValido}\nTriângulo OK: ${seguranca.trianguloOk}\nChave de Roda OK: ${seguranca.chaveDeRodaOk}\nMacaco OK: ${seguranca.macacoOk}\nKit Primeiros Socorros OK: ${seguranca.kitPrimeirosSocorrosOk}\nDocumentos Válidos: ${seguranca.documentosValidos}';
        break;
      default:
        text = 'Resumo indisponível para esta seção.';
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Título da seção atual
            Center(
              child: Text(
                sectionTitles[currentSection],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16), // Espaçamento após o título
            _buildSectionForm(),
          ],
        ),
      ),
      bottomNavigationBar: MyNavigationBar(
        currentIndex: getCurrentIndex(context),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ◀️ Botão Anterior
          FloatingActionButton.extended(
            heroTag: 'prev',
            label: const Text('Anterior'),
            icon: const Icon(Icons.arrow_back),
            onPressed: _prevSection,
          ),
          // ℹ️ Botão Resumo (para a seção atual)
          FloatingActionButton.extended(
            heroTag: 'summary',
            label: const Text('Resumo da Seção'),
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: Colors.grey[900],
                  title: Text('Resumo - ${sectionTitles[currentSection]}',
                      style: TextStyle(color: Colors.white)),
                  content: _buildSectionSummary(),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Fechar',
                          style: TextStyle(color: Colors.lightBlueAccent)),
                    ),
                  ],
                ),
              );
            },
          ),
          // ▶️ Botão Próximo
          FloatingActionButton.extended(
            heroTag: 'next',
            label: Text(currentSection == sectionTitles.length - 1
                ? 'Concluir'
                : 'Próximo'),
            icon: Icon(currentSection == sectionTitles.length - 1
                ? Icons.check
                : Icons.arrow_forward),
            onPressed: _nextSection,
          ),
        ],
      ),
    );
  }
}
