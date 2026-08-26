import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horários da Semana',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TelaHorarios(),
    );
  }
}

class TelaHorarios extends StatefulWidget {
  const TelaHorarios({super.key});

  @override
  State<TelaHorarios> createState() => _TelaHorariosState();
}

class _TelaHorariosState extends State<TelaHorarios> {
  final Map<String, List<String>> horarios = {
    'Segunda': ['Portugues', '08:40 às 11:30'],
    'Terça': ['Matematica', '15:00 às 19:50'],
    'Quarta': ['SW', '16:10 às 17:00'],
    'Quinta': ['TCC', '18:40 às 20:30'],
    'Sexta': ['Sem horário cadastrado'],
  };

  String diaSelecionado = '';

  void selecionarDia(String dia) {
    setState(() {
      diaSelecionado = dia;
    });

    final mensagem = horarios[dia]!.join(' - ');

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), duration: const Duration(seconds: 2)),
    );
  }

  Widget criarBotao(String dia) {
    return ElevatedButton(
      onPressed: () => selecionarDia(dia),
      child: Text(dia),
    );
  }

  @override
  Widget build(BuildContext context) {
    final horariosSelecionados = horarios[diaSelecionado] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horários da Semana'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_month,
                size: 70,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 16),
              const Text(
                'Selecione um dia da semana',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  criarBotao('Segunda'),
                  criarBotao('Terça'),
                  criarBotao('Quarta'),
                  criarBotao('Quinta'),
                  criarBotao('Sexta'),
                ],
              ),
              const SizedBox(height: 30),
              if (diaSelecionado.isNotEmpty)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          diaSelecionado,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 12),
                        for (final horario in horariosSelecionados)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Text(
                              horario,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
