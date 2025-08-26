// DataView struct definition and core methods

///|
pub struct DataView {
  data : ArrayView[Byte]
}

///| Create a new DataView from ArrayView[Byte] with optional offset
pub fn DataView::new(data : ArrayView[Byte], offset~ : Int = 0) -> DataView {
  if offset < 0 || offset > data.length() {
    abort("DataView offset out of bounds")
  }
  { data: data[offset:] }
}

///| Create a DataView from bytes with optional offset and length
pub fn DataView::from_bytes(
  data : ArrayView[Byte],
  offset~ : Int = 0,
  length~ : Int? = None,
) -> DataView {
  if offset < 0 || offset > data.length() {
    abort("DataView offset out of bounds")
  }
  let end_offset = match length {
    None => data.length()
    Some(len) => {
      if len < 0 {
        abort("DataView length cannot be negative")
      }
      let calculated_end = offset + len
      if calculated_end > data.length() {
        abort("DataView length + offset exceeds data bounds")
      }
      calculated_end
    }
  }
  { data: data[offset:end_offset] }
}

///| Get the byte length of this DataView
pub fn DataView::byte_length(self : DataView) -> Int {
  self.data.length()
}

///| Get the byte offset of this DataView
pub fn DataView::byte_offset(_self : DataView) -> Int {
  0
}

///| Check if the given offset and size are within bounds
pub fn DataView::check_bounds(
  self : DataView,
  byte_offset : Int,
  byte_size : Int,
) -> Unit {
  if byte_offset < 0 {
    abort("DataView byte_offset cannot be negative")
  }
  if byte_size <= 0 {
    abort("DataView byte_size must be positive")
  }
  if byte_offset + byte_size > self.data.length() {
    abort("DataView access out of bounds")
  }
}
