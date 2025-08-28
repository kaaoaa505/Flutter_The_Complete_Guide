<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Message;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class MessageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): JsonResponse
    {
        $messages = Message::with('user')->orderBy('created_at', 'asc')->get();
        return response()->json([
            'success' => true,
            'data' => $messages
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'content' => 'required|string',
        ]);

        $message = Message::create([
            'user_id' => $request->user()->id,
            'content' => $request->content,
        ]);

        // Load the user relationship
        $message->load('user');

        return response()->json([
            'success' => true,
            'data' => $message,
            'message' => 'Message sent successfully'
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Message $message): JsonResponse
    {
        $message->load('user');
        return response()->json([
            'success' => true,
            'data' => $message
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Message $message): JsonResponse
    {
        // Check if user owns the message
        if ($message->user_id !== $request->user()->id) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized to update this message'
            ], 403);
        }

        $request->validate([
            'content' => 'required|string',
        ]);

        $message->update([
            'content' => $request->content,
        ]);

        $message->load('user');

        return response()->json([
            'success' => true,
            'data' => $message,
            'message' => 'Message updated successfully'
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, Message $message): JsonResponse
    {
        // Check if user owns the message
        if ($message->user_id !== $request->user()->id) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized to delete this message'
            ], 403);
        }

        $message->delete();

        return response()->json([
            'success' => true,
            'message' => 'Message deleted successfully'
        ]);
    }
}
