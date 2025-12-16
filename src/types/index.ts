export type Product = {
  product_id: string;
  name: string;
  description?: string;
  category: string;
  brand?: string;
  price: number;
  tags?: string[] | null;
  created_at?: string;
  is_active?: boolean;
};

export type User = {
  user_id: string;
  email: string;
  first_name?: string;
  last_name?: string;
  preferences?: any;
};

export type Interaction = {
  interaction_id: string;
  user_id: string;
  product_id: string;
  interaction_type: 'view' | 'purchase' | 'wishlist';
  created_at?: string;
};
