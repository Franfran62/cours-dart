enum PaiementType {
    nondit,
    cb, 
    espece, 
    ticketRestaurant, 
    virement, 
    cheque;

    String getName() {
      switch (this) {
        case PaiementType.cb:
          return 'Carte Bancaire';
        case PaiementType.espece:
          return 'Espèce';
        case PaiementType.ticketRestaurant:
          return 'Ticket Restaurant';
        case PaiementType.virement:
          return 'Virement téléphone';
        case PaiementType.cheque:
          return 'Chèque';
        default:
          return "Non communiqué";
      }
    }
}