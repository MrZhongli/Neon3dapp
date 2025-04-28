import 'package:flutter/material.dart';

void main() => runApp(CalculadoraApp());

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Costos 3D',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: CalculadoraPage(),
    );
  }
}

class CalculadoraPage extends StatefulWidget {
  @override
  _CalculadoraPageState createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _precioKgController = TextEditingController();
  final TextEditingController _horasController = TextEditingController();
  final TextEditingController _minutosController = TextEditingController();

  double _margenGanancia = 100;
  double _tarifaHora = 0.25;
  bool _incluirTiempo = true;

  double _costoPorGramo = 0;
  double _costoMaterial = 0;
  double _costoTiempo = 0;
  double _costoBase = 0;
  double _costoTotal = 0;
  double _ganancia = 0;

  void _calcularCostos() {
    final peso = double.tryParse(_pesoController.text) ?? 0;
    final precioKg = double.tryParse(_precioKgController.text) ?? 0;
    final horas = double.tryParse(_horasController.text) ?? 0;
    final minutos = double.tryParse(_minutosController.text) ?? 0;

    setState(() {
      _costoPorGramo = precioKg / 1000;
      _costoMaterial = peso * _costoPorGramo;

      if (_incluirTiempo) {
        final totalHoras = horas + (minutos / 60);
        _costoTiempo = totalHoras * _tarifaHora;
      } else {
        _costoTiempo = 0;
      }

      _costoBase = _costoMaterial + _costoTiempo;
      _costoTotal = _costoBase * (1 + _margenGanancia / 100);
      _ganancia = _costoTotal - _costoBase;
    });
  }

  Widget _campoEntrada(String etiqueta, TextEditingController controlador, {String? sufijo}) {
    return TextField(
      controller: controlador,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: etiqueta,
        suffixText: sufijo,
        border: OutlineInputBorder(),
      ),
      onChanged: (_) => _calcularCostos(),
    );
  }

  Widget _seccionResultados() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Costo por gramo: \$${_costoPorGramo.toStringAsFixed(4)}'),
        Text('Costo de material: \$${_costoMaterial.toStringAsFixed(2)}'),
        if (_incluirTiempo)
          Text('Costo por tiempo: \$${_costoTiempo.toStringAsFixed(2)}'),
        Divider(),
        Text('Costo base: \$${_costoBase.toStringAsFixed(2)}'),
        Text('Margen de ganancia: ${_margenGanancia.toStringAsFixed(0)}%'),
        Text('Ganancia: \$${_ganancia.toStringAsFixed(2)}'),
        Divider(),
        Text('Precio final: \$${_costoTotal.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _selectorTarifaHora() {
    final opciones = [0.25, 0.35, 0.45];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: opciones.map((tarifa) {
        return ChoiceChip(
          label: Text('\$${tarifa.toStringAsFixed(2)}'),
          selected: _tarifaHora == tarifa,
          onSelected: (_) {
            setState(() {
              _tarifaHora = tarifa;
              _calcularCostos();
            });
          },
        );
      }).toList(),
    );
  }

  Widget _selectorMargenGanancia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Margen de ganancia: ${_margenGanancia.toStringAsFixed(0)}%'),
        Slider(
          value: _margenGanancia,
          min: 0,
          max: 500,
          divisions: 100,
          label: '${_margenGanancia.toStringAsFixed(0)}%',
          onChanged: (valor) {
            setState(() {
              _margenGanancia = valor;
              _calcularCostos();
            });
          },
        ),
      ],
    );
  }

  Widget _seccionTiempo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text('Incluir cálculo por tiempo'),
          value: _incluirTiempo,
          onChanged: (valor) {
            setState(() {
              _incluirTiempo = valor;
              _calcularCostos();
            });
          },
        ),
        if (_incluirTiempo)
          Row(
            children: [
              Expanded(child: _campoEntrada('Horas', _horasController)),
              SizedBox(width: 10),
              Expanded(child: _campoEntrada('Minutos', _minutosController)),
            ],
          ),
        if (_incluirTiempo) _selectorTarifaHora(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _calcularCostos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Costos 3D'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _campoEntrada('Peso del objeto (g)', _pesoController, sufijo: 'g'),
            SizedBox(height: 10),
            _campoEntrada('Precio del filamento (por Kg)', _precioKgController, sufijo: '\$'),
            SizedBox(height: 10),
            _seccionTiempo(),
            SizedBox(height: 10),
            _selectorMargenGanancia(),
            Divider(),
            _seccionResultados(),
          ],
        ),
      ),
    );
  }
}