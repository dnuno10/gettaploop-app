import 'package:flutter_test/flutter_test.dart';
import 'package:taploop/core/utils/stored_text.dart';
import 'package:taploop/features/card/models/contact_item_model.dart';

void main() {
  test('translates stored Spanish presets', () {
    expect(localizeStoredText('Teléfono'), 'Phone');
    expect(localizeStoredText('  sitio web '), 'Website');
    expect(localizeStoredText('Agenda una reunión'), 'Schedule a meeting');
    expect(localizeStoredText('Cotización'), 'Quote');
    expect(localizeStoredText('Nueva tarjeta'), 'New card');
  });

  test('keeps free text and names untouched', () {
    expect(localizeStoredText('Oficina Monterrey'), 'Oficina Monterrey');
    expect(localizeStoredText('Dirección Comercial'), 'Dirección Comercial');
    expect(localizeStoredText('Juan García'), 'Juan García');
  });

  test('saving a contact keeps the stored Spanish label', () {
    const item = ContactItemModel(
      id: '1',
      type: ContactType.phone,
      value: '5551234567',
      label: 'Teléfono',
    );
    expect(item.toJson(cardId: 'card')['label'], 'Teléfono');
  });
}
