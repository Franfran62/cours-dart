enum Size {
  Small, Medium, Large, ExtraLarge;

 String getAcronyme() {
   switch (this) {
    case Size.Small:
      return 'S';
    case Size.Medium:
      return 'M';
    case Size.Large:
      return 'L';
    case Size.ExtraLarge:
      return 'XL';
  }
 }
}