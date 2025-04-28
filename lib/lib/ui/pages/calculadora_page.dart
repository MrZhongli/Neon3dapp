import 'package:flutter/material.dart';

/// Pantalla principal con cálculo 3D.
class Page3DApp extends StatelessWidget {
  const Page3DApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora 3D',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const CalculatorPage(),
    );
  }
}

/// Página de calculadora 3D con lógica y UI minimalista.
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  CalculatorPageState createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _pesoC = TextEditingController();
  final TextEditingController _precioC = TextEditingController();
  final TextEditingController _horasC = TextEditingController();
  final TextEditingController _minC = TextEditingController();

  double _margen = 100;
  double _tarifa = 0.25;
  bool _incluirTiempo = true;
  double _cGramo = 0, _cMat = 0, _cTiempo = 0, _cBase = 0, _cTotal = 0, _gan = 0;

  void _calc() {
    final p = double.tryParse(_pesoC.text) ?? 0;
    final pk = double.tryParse(_precioC.text) ?? 0;
    final h = double.tryParse(_horasC.text) ?? 0;
    final m = double.tryParse(_minC.text) ?? 0;
    setState(() {
      _cGramo = pk / 1000;
      _cMat = p * _cGramo;
      _cTiempo = _incluirTiempo ? (h + m / 60) * _tarifa : 0;
      _cBase = _cMat + _cTiempo;
      _cTotal = _cBase * (1 + _margen / 100);
      _gan = _cTotal - _cBase;
    });
  }

  Widget _tf(String lbl, TextEditingController c, {String? suf}) {
    return TextField(
      controller: c,
      style: const TextStyle(color: Colors.white),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: lbl,
        labelStyle: const TextStyle(color: Color(0xFFAAAAAA)),
        suffixText: suf,
        filled: true,
        fillColor: const Color(0xFF1E1E1E),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (_) => _calc(),
    );
  }

  Widget _sliderMargen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Margen: ${_margen.toStringAsFixed(0)}%', style: const TextStyle(color: Colors.white)),
        Slider(
          min: 0, max: 500, divisions: 100,
          value: _margen,
          activeColor: const Color(0xFFCCFF00), inactiveColor: const Color(0xFF333333),
          label: '${_margen.toStringAsFixed(0)}%',
          onChanged: (v) => setState(() { _margen = v; _calc(); }),
        ),
      ],
    );
  }

  Widget _resumen() {
    final rows = [
      ['Costo/g', _cGramo], ['Material', _cMat],
      if (_incluirTiempo) ['Tiempo', _cTiempo],
      ['Base', _cBase], ['Ganancia', _gan], ['Total', _cTotal]
    ];
    return Container(
      padding: const EdgeInsets.all(16), margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: rows.map((r) => Padding(
          padding: const EdgeInsets.symmetric(vertical:4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(r[0] as String, style: const TextStyle(color: Color(0xFFAAAAAA))),
              Text('\$${(r[1] as double).toStringAsFixed(r[0]=='Costo/g'?4:2)}',
                style: TextStyle(
                  color: (r[0]=='Ganancia'||r[0]=='Total') ? const Color(0xFFCCFF00) : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )).toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _calc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Row(children: [
                Text('3D', style: TextStyle(color: const Color(0xFFCCFF00), fontSize:28, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(icon: const Icon(Icons.settings, color: Color(0xFFCCFF00)), onPressed: (){}),
              ]),
              const SizedBox(height:24),
              _tf('Peso (g)', _pesoC, suf: 'g'),
              const SizedBox(height:12),
              _tf('Precio por Kg', _precioC, suf: '\$'),
              const SizedBox(height:12),
              SwitchListTile.adaptive(
                value: _incluirTiempo,
                onChanged: (v) => setState(() { _incluirTiempo=v; _calc(); }),
                title: const Text('Incluir tiempo', style: TextStyle(color:Colors.white)),
                activeColor: const Color(0xFFCCFF00), contentPadding: EdgeInsets.zero,
              ),
              if(_incluirTiempo)...[
                _tf('Horas', _horasC),
                const SizedBox(height:12),
                _tf('Minutos', _minC),
                const SizedBox(height:12),
              ],
              _sliderMargen(),
              _resumen(),
              ElevatedButton(
                onPressed: _calc,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCCFF00), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical:16),
                ),
                child: const Text('Calcular', style: TextStyle(color:Colors.black,fontWeight:FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}